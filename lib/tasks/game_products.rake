require 'mechanize'
require 'nokogiri'
require 'json'
require 'yaml'
require 'csv'

class ScraperBase
  attr_accessor :properties

  # initialize method
  def initialize
    reset_mechanize_object
    # total number of requests
    @request_count = 0
    @properties = {}
  end
  
  def reset_mechanize_object
    @agent = Mechanize.new
    @agent.read_timeout = 100     # http read timout
    @agent.open_timeout = 100     # http open timeout
    @agent.user_agent_alias = 'Windows IE 7'
    @agent.keep_alive = false
    @agent.pluggable_parser.default = Mechanize::Page
    #@agent.set_proxy("us.proxymesh.com", 31280, "acast317", "2013proxy")
  end
  
  def send_request(uri, params = nil, headers = {})
    tries = 0
    page = nil
    log_output uri
    
    begin
      #@request_count += 1
      page = params.nil? ? @agent.get(uri) : @agent.post(uri, params, headers)
      
    rescue StandardError => ex
      errstr = "\n\t#{ex.message}"
      errstr += "\n\t#{ex.backtrace.join("\n\t")}"
      log_output errstr
      
      log_output "Failed to open page. try it again"
      tries += 1
      sleep(2)
      retry if tries < 3
    end
    
    log_output("Failed to open page") if page.nil?
    
    return page
  end
  
  def log_output(msg)
    puts msg
  end
  
  # get timestamp
  def timestamp
    Time.now.to_i.to_s
  end
  
  def get_hidden_value(page, name)
    return page.search("input[@name='#{name}']").first['value']
  end
  
  def get_attr_with_pattern(page, pattern, attr_name)
    tmp_obj = page.search(pattern).first
    tmp_obj.nil? ? "" : tmp_obj.attr(attr_name)
  end
  
  def get_text_with_pattern(page, pattern)
    tmp_obj = page.search(pattern).first
    tmp_obj.nil? ? "" : remove_unuseful(tmp_obj.text.to_s)
  end
  
  def get_next_element_text(page, pattern, match = 0)
    get_n_next_element_text(page, pattern, 1, match)
  end
  
  def get_n_next_element_text(page, pattern, n, match = 0)
    return_str = ""
    tmp_obj = page.search(pattern)[match]

    unless tmp_obj.nil?
      (1..n).each do |step|
        tmp_obj = tmp_obj.next_element
        break if tmp_obj.nil?
        return_str = tmp_obj.text
      end
    end

    return remove_unuseful(return_str)
  end
  
  def get_parent_element_text(page, pattern)
    get_n_parent_element_text(page, pattern, 1)
  end

  def get_n_parent_element_text(page, pattern, n)
    return_str = ""
    tmp_obj = page.search(pattern).first
    
    unless tmp_obj.nil?
      (1..n).each do |step|
        tmp_obj = tmp_obj.parent
        break if tmp_obj.nil?
        return_str = tmp_obj.text
      end
    end

    return remove_unuseful(return_str)
  end

  def get_parent_next_element_text(page, pattern)
    get_parent_n_next_element_text(page, pattern, 1)
  end
  
  def get_parent_n_next_element_text(page, pattern, n)
    return_str = ""
    tmp_obj = page.search(pattern).first
    
    unless tmp_obj.nil?
      tmp_obj = tmp_obj.parent
      (1..n).each do |step|
        tmp_obj = tmp_obj.next_element
        break if tmp_obj.nil?
        return_str = tmp_obj.text
      end
    end
    
    return remove_unuseful(return_str)
  end
  
  def remove_unuseful(str)
    str.gsub("\n", " ").gsub("\t", "").strip.force_encoding("utf-8")
  end
  
  def get_number(str)
    str[/(\d+)/, 1]
  end
  
  def get_neighborhood(str)
    tmp_result = str[/Neighborhoods: (.*)$/, 1]
    tmp_result = str[/Neighborhood: (.*)$/, 1] if tmp_result.nil?
    tmp_result
  end

  def parse_date(str)
    unless str.empty?
      tmp_array = str.split("/")
      Date.parse("#{tmp_array[2]}-#{tmp_array[0]}-#{tmp_array[1]}")
    else
      nil
    end
  rescue
    nil
  end

  def add_properites(element)
    while !element.nil?
      key = element.text().downcase.gsub(/(\s+|-)/, '_').to_sym
      element = element.next_element
      unless element.nil?
        unless key.to_s.blank?
          @properties[key] = element.search('a').map { |link| link.text().force_encoding("utf-8") }.join(', ')
        end
        element = element.next_element
      end
    end
  end

  def parseDate(string)
    date = Date.parse(string) rescue nil
    if date.nil?
      date = Date.parse("#{string[3..4]}/#{string[0..1]}/#{string[6..-1]}") rescue nil
    end
    if date.nil?
      date = Date.parse(string + '-01-01') rescue nil
    end
    date
  end
end

task game_products: :environment do
	base_url = "http://www.mobygames.com"
	agent = ScraperBase.new()
  total_games = 141164
  count = 0
  page_num = 0
  total_count = 0
  
  agent.log_output "Starting..."

	while count < total_games
		list_page = agent.send_request "#{base_url}/browse/games/offset,#{count}/so,0a/list-games/"
    page_num += 1
    agent.log_output "current page = #{page_num}"

		list_page.search('table[@id="mof_object_list"] tr[@valign="top"]').each do |item|
			appendix = item.search('td').first.search('a').first['href']
      agent.properties[:url] = base_url + appendix
      game_page = agent.send_request agent.properties[:url]

      agent.properties[:title] = agent.get_text_with_pattern(game_page, 'div#gameTitle a')
      agent.properties[:image] = agent.get_attr_with_pattern(game_page, 'div#coreGameCover img', 'src')
      agent.properties[:description] = game_page.search('div.rightPanelMain').first.inner_html()

      element = game_page.search("div#coreGameRelease").first.search('div').first
      agent.add_properites(element)

      element = game_page.search("div#coreGameGenre").first.search('div').first.search('div').first
      agent.add_properites(element)

      #agent.log_output agent.properties.inspect
      product_genre = ProductGenre.find_or_create_by_name(agent.properties[:genre])
      agent.properties[:product_genre_id] = product_genre.id
      agent.properties[:genre] = 'Game'
      agent.properties[:user_id] = 1
      agent.properties[:date] = agent.properties[:released]
      agent.properties[:year] = agent.parseDate(agent.properties[:released])

      product = Product.where(title: agent.properties[:title], genre: 'Game').first
      unless product.nil?
        product.update_attributes(agent.properties)
      else
        product = Product.create(agent.properties)
      end
      product.save!

      total_count += 1
		end
    
    count += 25
	end

  agent.log_output "\nJob was finished successfully. Total game counts = #{total_count}"
end	