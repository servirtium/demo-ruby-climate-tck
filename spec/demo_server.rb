require 'webrick'
require 'ostruct'

module ServirtiumDemo
  class DemoServlet
    def self.add(a, b)
      a.to_i + b.to_i
    end

    def self.subtract(a, b)
      a.to_i - b.to_i
    end
  end

  class ServirtiumServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(request, response)

      if request.query['a'] && request.query['b']
        a = request.query['a']
        b = request.query['b']
        response.status = 200
        response.content_type = 'application/json'

        result = case request.path
                 when '/add'
                   DemoServlet.add(a, b)
                 when '/subtract'
                   DemoServlet.subtract(a, b)
                 else
                   'No such method'
                 end

        response.body = result.to_s + "\n"
      else
        response.status = 200
        response.body = json_response
      end
    end

    private

    def default_response
      'You did not provide the correct parameters'
    end

    def json_response
      response = <<-RESPONSE
[{"gcm":"bccr_bcm2_0","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[987.9504418944]},{"gcm":"cccma_cgcm3_1","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[815.2627636718801]},{"gcm":"cnrm_cm3","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1099.3898999037601]},{"gcm":"csiro_mk3_5","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1021.6996069333198]},{"gcm":"gfdl_cm2_0","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1019.8750146478401]},{"gcm":"gfdl_cm2_1","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1084.5603759764]},{"gcm":"ingv_echam4","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1008.2985131833999]},{"gcm":"inmcm3_0","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1194.9564575200002]},{"gcm":"ipsl_cm4","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[893.9680444336799]},{"gcm":"miroc3_2_medres","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1032.85460449136]},{"gcm":"miub_echo_g","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[905.9324633786798]},{"gcm":"mpi_echam5","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1024.2805590819598]},{"gcm":"mri_cgcm2_3_2a","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[784.5488305664002]},{"gcm":"ukmo_hadcm3","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[957.3522631840398]},{"gcm":"ukmo_hadgem1","variable":"pr","fromYear":1980,"toYear":1999,"annualData":[1001.7526196294]}]
      RESPONSE
      response
    end

    def xml_response
      response = <<-RESPONSE
<list>
  <domain.web.AnnualGcmDatum>
    <gcm>bccr_bcm2_0</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>987.9504418944</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>cccma_cgcm3_1</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>815.2627636718801</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>cnrm_cm3</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1099.3898999037601</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>csiro_mk3_5</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1021.6996069333198</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>gfdl_cm2_0</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1019.8750146478401</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>gfdl_cm2_1</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1084.5603759764</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>ingv_echam4</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1008.2985131833999</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>inmcm3_0</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1194.9564575200002</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>ipsl_cm4</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>893.9680444336799</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>miroc3_2_medres</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1032.85460449136</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>miub_echo_g</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>905.9324633786798</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>mpi_echam5</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1024.2805590819598</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>mri_cgcm2_3_2a</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>784.5488305664002</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>ukmo_hadcm3</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>957.3522631840398</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
  <domain.web.AnnualGcmDatum>
    <gcm>ukmo_hadgem1</gcm>
    <variable>pr</variable>
    <fromYear>1980</fromYear>
    <toYear>1999</toYear>
    <annualData>
      <double>1001.7526196294</double>
    </annualData>
  </domain.web.AnnualGcmDatum>
</list>
      RESPONSE
      response
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

      @interactions = Array.new
      markdown_string = "\n" + File.read("spec/lib/mocks/" + ctx.downcase.gsub(" ", "_") + ".md")
      interactons = markdown_string.split("\n## Interaction ")
      if interactons[0].length === 0
        interactons = interactons.drop(1)
      end

      interactons.each_with_index do |val, index|
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

        @interactions << interaction

      end

    end
  end
end
