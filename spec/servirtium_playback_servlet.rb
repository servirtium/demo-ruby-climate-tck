# frozen_string_literal: true

require 'rdoc'
require 'webrick'

module ServirtiumDemo
  class << self
    attr_accessor :example
    attr_accessor :interaction
  end

  class ServirtiumPlaybackServlet < WEBrick::HTTPServlet::AbstractServlet
    # rubocop:disable Naming/MethodName
    def do_GET(_request, response)
      @responses ||= []

      response.content_type = 'application/xml'
      response.status = 200
      response.body = default_response

      playback_file = find_playback_file_for ServirtiumDemo.example
      response.body = retrieve_body_from playback_file if playback_file

      response
    end

    # rubocop:enable Naming/MethodName

    private

    def default_response
      "No playback file was found for #{ServirtiumDemo.example}"
    end

    def find_playback_file_for(example_path)
      filepath = "spec/lib/mocks/#{example_path}.md"
      return filepath if File.exist? filepath

      raise StandardError, "File [#{filepath}] not found"
    end

    def retrieve_body_from(playback_file)
      markdown_file = File.read(playback_file)
      doc = RDoc::Markdown.parse(markdown_file)
      parse_responses(doc)
      response = @responses[ServirtiumDemo.interaction].parts.first
      ServirtiumDemo.interaction = ServirtiumDemo.interaction + 1
      response
    rescue StandardError => _e
      raise
    end

    def parse_responses(doc)
      @responses = []
      take_next = false
      doc.entries.each do |entry|
        @responses << entry if take_next
        take_next = entry.text.start_with? 'Response body recorded for playback'
      end
    end
  end
end
