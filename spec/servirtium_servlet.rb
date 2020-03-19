# frozen_string_literal: true

require 'rdoc'
require 'redcarpet'
require 'webrick'

module ServirtiumDemo
  class << self
    attr_accessor :example
    attr_accessor :interaction
    attr_accessor :record
  end

  class ServirtiumServlet < WEBrick::HTTPServlet::AbstractServlet
    # rubocop:disable Naming/MethodName
    def do_GET(request, response)
      @responses ||= []

      response.content_type = 'application/xml'
      response.status = 200
      response.body = default_response

      record_new_response ServirtiumDemo.example, request if ServirtiumDemo.record

      playback_file = find_playback_file_for ServirtiumDemo.example
      response.body = retrieve_body_from playback_file if playback_file

      response
    end

    # rubocop:enable Naming/MethodName

    private

    def default_response
      "No playback file was found for #{ServirtiumDemo.example}"
    end

    def record_new_response(example_path, request)
      filepath = playback_filepath example_path
      f = File.new(filepath, 'w')
      f.write(build_recording(request))
      f.close
    end

    def find_playback_file_for(example_path)
      filepath = playback_filepath example_path
      return filepath if File.exist? filepath

      raise StandardError, "File [#{filepath}] not found"
    end

    def playback_filepath(example_path)
      "spec/lib/mocks/#{example_path}.md"
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

    # rubocop:disable Metrics/MethodLength
    def build_recording(request)
      recording = <<~RECORDING
        ## Interaction #{ServirtiumDemo.interaction}: #{request.request_method} #{request.path}

        ### Request headers recorded for playback:

        ```
        Host: #{ServirtiumDemo.domain.split('//').last}
        User-Agent: #{request.header['user-agent']}
        Accept-Encoding: #{request.header['accept-encoding']}
        Accept: #{request.header['accept']}
        Connection: #{request.header['connection']}
        ```

        ### Request body recorded for playback ():

        ```


        ```

        ### Response headers recorded for playback:

        ```
        Content-Type: application/xml
        Connection: keep-alive
        Access-Control-Allow-Origin: *
        Access-Control-Allow-Headers: X-Requested-With
        Access-Control-Allow-Methods: GET
        Strict-Transport-Security: max-age=31536000; includeSubDomains
        Content-Security-Policy: default-src 'self'
        Cache-Control: no-cache
        Secure: true
        HttpOnly: true
        Transfer-Encoding: chunked
        ```

        ### Response body recorded for playback (200: application/xml):

        ```
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
        ```
      RECORDING
      recording
    end
    # rubocop:enable Metrics/MethodLength
  end
end
