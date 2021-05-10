# frozen_string_literal: true

module Pipedrive

  class Lead < Resource
    include Fields

    def self.fields_url
      "dealFields"
    end

    def create(params)

      response = request(
        :post,
        resource_url,
        search_for_fields(params)
      )
      new(response.dig(:data))
    end

    def update(params)
      response = request(
        :patch,
        resource_url,
        params
      )
      update_attributes(response.dig(:data))
    end

    def self.search(term, params = {})
      puts "Starting Search..."
      response = request(
        :get,
        "#{resource_url}",
        params
      )
      data = response.dig(:data).reject {|lead| lead.dig(:title) != term }
      data.map {|d| new(d)}
    end

  end

end
