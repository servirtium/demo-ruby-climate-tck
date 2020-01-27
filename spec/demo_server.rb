require 'webrick'
require 'ostruct'

module ServirtiumDemo

  class << self; attr_accessor :interactionIndex; end
  class << self; attr_accessor :interactions; end

  class ServirtiumServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(request, response)

      # response.status = 200
      # response.body = json_response

      this_interaction = ServirtiumDemo.interactions[ServirtiumDemo.interactionIndex]
      ServirtiumDemo.interactionIndex += 1

      response.status = this_interaction.responseStatusCode
      this_interaction.responseHeaders.split("\n").each do |hdr|
        response[hdr.split(": ")[0]] = hdr.split(": ")[1]
      end
      response.body = this_interaction.responseBody

    end

    private

    def default_response
      'You did not provide the correct parameters'
    end
  end

  class DemoServer

    context = ""

    def initialize
      @server = WEBrick::HTTPServer.new(Port: 61_417)

      @server.mount "/", ServirtiumServlet

      trap("INT") {
        @server.shutdown
      }
    end

    def start
      @server.start
    end

    def stop
      @server.shutdown
    end

    def updateContext(ctx)

      ServirtiumDemo.interactionIndex = 0
      ServirtiumDemo.interactions = Array.new

      file = "spec/lib/mocks/" + ctx.downcase.gsub(" ", "_") + ".md"
      puts "looking for " + file
      markdown_string = "\n" + File.read(file)
      interactonz = markdown_string.split("\n## Interaction ")
      if interactonz[0].length === 0
        interactonz = interactonz.drop(1)
      end

      interactonz.each_with_index do |val, index|
        raise "Oops: " + val unless val.index(index.to_s + ": ") == 0

        line1 = val.split("\n")[0]
        verb = line1.split(" ")[1]
        url = line1.split(" ")[2]

        interaction = OpenStruct.new

        interaction.requestVerb = verb
        interaction.requestURL = url

        puts "Playback's verb: " + verb + " and url: " + url

        fiveBits = val.split("\n### Re")

        fourBits = fiveBits.drop(1)


        raise "Oops2: " + fourBits[0] unless fourBits[0].index("quest headers recorded for playback:\n") == 0
        interaction.requestHeaders = fourBits[0].split("\n```\n")[1]

        ## should fail if encountered headers are NOT the same as the headers in the playback

        raise "Oops3: " + fourBits[1] unless fourBits[1].index("quest body recorded for playback (") == 0
        # note: there is extra info in that ##-line to parse
        interaction.requestBody = fourBits[1].split("\n```\n")[1]

        ## should fail if encountered body are NOT the same as the body in the playback

        raise "Oops3: " + fourBits[2] unless fourBits[2].index("sponse headers recorded for playback:\n") == 0
        interaction.responseHeaders = fourBits[2].split("\n```\n")[1]

        raise "Oops4: " + fourBits[3] unless fourBits[3].index("sponse body recorded for playback (") == 0
        line1 = fourBits[3].split("\n")[0]
        statusCode = line1.split(" ")[5].gsub("(", "").gsub(":", "")
        mimeType = line1.split(" ")[6].gsub(")", "").gsub(":", "")
        puts "Playback's statusCode: " + statusCode + " and mimeType: " + mimeType
        interaction.responseStatusCode = statusCode
        interaction.responseMimeType = mimeType
        interaction.responseBody = fourBits[3].split("\n```\n")[1]

        ServirtiumDemo.interactions << interaction

      end
    end
  end
end
