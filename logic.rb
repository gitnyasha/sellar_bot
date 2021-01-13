require "uri"
require "net/http"

module Sellai
  def self.product
    url = URI("https://sleepy-inlet-66489.herokuapp.com/api/v1/products")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = "no-cache"
    request["postman-token"] = "342eb263-493c-d557-1a7f-f090d7313702"

    response = http.request(request)
    jso = response.read_body
    val = jso.map { |h| [h["id"], h["name"], h["description"], "$#{h["price"]}0", "https://wa.me/+263#{h["phone"]}", h["location"]] }.compact
    val.join("\n")
  end

  def self.service
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/services"
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = "no-cache"
    request["postman-token"] = "342eb263-493c-d557-1a7f-f090d7313702"

    response = http.request(request)
    jso = response.read_body
    val = jso.map { |h| [h["id"], h["name"], h["description"], "https://wa.me/+263#{h["phone"]}", h["location"]] }.compact
    val.join("\n")
  end

  def self.demands
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/demands"
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = "no-cache"
    request["postman-token"] = "342eb263-493c-d557-1a7f-f090d7313702"

    response = http.request(request)
    jso = response.read_body
    val = jso.map { |h| [h["detail"]] }.compact
    val.join("\n\n")
  end
end
