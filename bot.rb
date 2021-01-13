require "sinatra/base"
require "telegram/bot"
require_relative "logic"

class TeleBot < Sinatra::Base
  token = ENV["TELE_AUTH_TOKEN"]

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      offensive = ["tsek", "imbwa", "mhata", "mboro", "beche", "dinji", "matinji", "musuri", "nzvonyo", "nyini", "fuck", "penis", "vagina", "dick", "ass", "magaro", "pussy", "zanu", "mdc", "chamisa", "nyoro", "putseki", "nothing", "hapana"]
      body = message.text
      if body.include?("sellai") || body.include?("hello") || body.include?("sup") || body.include?("ndep") || body.include?("ndeipi") || body.include?("wadi") || body.include?("urisei") || body.include?("iwe")
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I am Sellai, an online marketplace. \n\n1) To a send a demand type 'send' and what you are looking for. \n\n2) To send feedback type 'feedback' and what you want us to improve or fix.\n\n3) To search for product or service just type the name of what you are looking for  \n\n\nVisit our site to register to become a seller and receive demand notifications \n https://sellaimarket.com")
      elsif body.include?("send")
        offensive.each do |s|
          if body.include?(s)
            bot.api.send_message(chat_id: message.chat.id, text: "I can't send offensive words!!")
            break
          else
            url = URI("https://sleepy-inlet-66489.herokuapp.com/api/v1/demands")

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            request = Net::HTTP::Post.new(url)
            request["content-type"] = "application/json"
            request.body = "{\n\t\"detail\": \"#{body}\"\n}"

            dresponse = http.request(request)
            dresponse = "Message has been send will notify our sellers."
            bot.api.send_message(chat_id: message.chat.id, text: "#{dresponse}")
            break
          end
        end
      elsif body.include?("feedback")
        url = URI("https://sleepy-inlet-66489.herokuapp.com/api/v1/feedbacks")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["content-type"] = "application/json"
        request.body = "{\n\t\"content\": \"#{body}\"\n}"

        fresponse = http.request(request)
        fresponse = "Message has been send we will reveal the feedback."
        bot.api.send_message(chat_id: message.chat.id, text: " #{fresponse}")
        # elsif body.include?(body)
        #   bot.api.send_message(chat_id: message.chat.id, text: "#{search}")
        #   bot.api.send_message(chat_id: message.chat.id, text: "#{search_service}")
      end
    end
  end

  def category
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/categories"
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = "no-cache"
    request["postman-token"] = "342eb263-493c-d557-1a7f-f090d7313702"

    response = http.request(request)
    jso = response.read_body
    val = jso.map { |h| h + +[h["name"]] }.compact
    val.join("\n")
  end

  def stype
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/servicetypes"
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = "no-cache"
    request["postman-token"] = "342eb263-493c-d557-1a7f-f090d7313702"

    response = http.request(request)
    jso = response.read_body
    val = jso.map { |h| [h["name"]] }.compact
    val.join("\n")
  end

  def search
    body = message.text
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/products?search=#{body}&commit=Search"
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

  def search_service
    body = message.text
    url = "https://sleepy-inlet-66489.herokuapp.com/api/v1/services?search=#{body}&commit=Search"
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
end
