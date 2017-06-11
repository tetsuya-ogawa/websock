require 'csv'
class ScrapingController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create]
  layout 'login'
  def index
    # wite_to_spreadsheet(params[:keyword])
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data genarate_csv(params[:keyword]), type: 'csv; charset=utf-8', filename: "#{params[:keyword]}.csv" }
    # end
  end

  def create
    @number = params[:number].to_i
    wite_to_spreadsheet(params[:keyword])
    render :index
  end

  def genarate_csv(keyword)
    @results = []
    torimochi = Torimochi.new
    torimochi.search_by(params[:keyword])
    torimochi.scraping('div.g') do |g|
      @results << [g.title, g.url, g.discription]
    end
    csv = CSV.generate do |csv|
      headers = %w(title url discription)
      csv << headers
      @results.each do |result|
        csv << result
      end
    end
    csv
  end

  def wite_to_spreadsheet(keyword)
    client_id     = ENV['GOOGLE_CLIENT_ID']
    client_secret = ENV['GOOGLE_CLIENT_SECRET']
    refresh_token = ENV['GOOGLE_REFRESH_TOKEN']
    client = OAuth2::Client.new(
        client_id,
        client_secret,
        site: "https://accounts.google.com",
        token_url: "/o/oauth2/token",
        authorize_url: "/o/oauth2/auth")
    auth_token = OAuth2::AccessToken.from_hash(client,{:refresh_token => refresh_token, :expires_at => 3600})
    auth_token = auth_token.refresh!
    session = GoogleDrive.login_with_oauth(auth_token.token)
    ws = session.spreadsheet_by_key("1aAbldqtUegugtVxQPWderzkQ7i2bTGCK1nq9cLjNSe0").worksheets[0]
    hashes = []
    torimochi = Torimochi.new
    torimochi.search_by(keyword)
    torimochi.scraping('div.g', 3) do |g|
      hashes << {
                 'タイトル' => g.title,
                 'URL' => g.url,
                 'メタディスクリプション' => g.discription
                }
    end
    hashes.each do |hash|
      ws.list.push(
        hash.each do |k, v|
        ["#{k}" => "#{v}"]
        end
      )
    end
   ws.save
  end
end
