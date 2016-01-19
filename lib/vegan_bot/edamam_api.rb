module VeganBot
  class EdamamApi
    include HTTMultiParty

    ENDPOINTS = %w(
      search
    ).freeze

    base_uri 'https://api.edamam.com/'

    def initialize(app_id, app_key)
      @auth = { app_id: app_id, app_key: app_key }
    end

    def method_missing(method_name, *args, &block)
      endpoint = method_name.to_s
      ENDPOINTS.include?(endpoint) ? call(endpoint, *args) : super
    end

    def call(endpoint, params = {})
      params.merge!(@auth)
      response = self.class.get("/#{endpoint}", {query: params})

      if response.code == 200
        response.to_hash
      else
        fail Exceptions::ResponseError.new(response),
             'Edamam API has returned the error.'
      end
    end
  end
end
