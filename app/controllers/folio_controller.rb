
require 'nokogiri'
require 'open-uri'

class FolioController < ApplicationController
    
    
    def index
      @user = current_user
    end
    
    def new
      
      f = Folio.find_by_user_id(current_user.nick)
      if f.nil?
        # 로그인된 아이디에 github아이디가 이미 저장되어있지않을때
        
       @folio = Folio.new
                @folio.gid = params[:input_name]
                @folio.user_id=current_user.nick
                @folio.intro = params[:introduce]
                @folio.save
                
                @user = User.find_by_nick(@folio.user_id)
                @user.github=params[:input_name]
                @user.save
                    
                ##############    
                url = "https://github.com/"+@folio.gid
                data = Nokogiri::HTML(open(url))
                @lists = data.css('span.repo')
                
                
                @lists.each do |l|

                    f = Folio.find_by_id(@folio.id)
                    @infos = f.infos.new
                    @infos.gid = @folio.id
                    @infos.folio_id = @folio.id
                    @infos.list = l.text.strip
                    @infos.save
                    
                    r_url = "https://github.com/"+@folio.gid+"/"+@infos.list+"/blob/master/README.md"
                        begin
                          file = open(r_url)
                            doc = Nokogiri::HTML(file) do
                            # handle doc
                            data = Nokogiri::HTML(open(r_url))
                            readme = data.css('div#readme').at("article[@itemprop = 'text']")
                            
                            rm = @infos.readmes.new
                            rm.readme = readme
                            rm.info_id = @infos.id
                            rm.rid = @infos.id
                            rm.gid = @folio.id
                            rm.save
                          end
                        rescue OpenURI::HTTPError => e
                          if e.message == '404 Not Found'
                            # handle 404 error
                            rm = @infos.readmes.new
                            rm.readme = "등록된 Readme.md 파일이 없습니다."
                            rm.info_id = @infos.id
                            rm.rid = @infos.id
                            rm.gid = @folio.id
                            rm.save
                          else
                            raise e
                          end
                        end    
                        
                    # data = Nokogiri::HTML(open(r_url))
                    # readme = data.css('div#readme').at("article[@itemprop = 'text']")
                    # rm = Readme.new
                    # rm.readme = readme
                    # rm.rid = @infos.id
                    # rm.gid = @folio.id
                    # rm.save
    
                end
                
                ################3
            
              
                url = "https://github.com/"+@folio.gid+"?tab=repositories"
                data = Nokogiri::HTML(open(url))
                @language = data.css('div.f6.text-gray.mt-2')
                @language.each do |lang|
                    # Readme.create(:read => readme.css('span.mr-3').text.strip)
                    #Readme.create(:read => readme.css('article').text.strip)
                    lg = lang.at("span[@itemprop = 'programmingLanguage']")
                    if lg !=nil
                    graph = @folio.graphs.new
                    graph.folio_id = @folio.id
                    graph.gid = @folio.id
                    graph.lang = lg.text
                    graph.save

                    end
                end
                
            
            redirect_to "/folio/#{@folio.user_id}"
             
      else
        
       @fol = Folio.find_by_user_id(current_user.nick)
       
       @fol.destroy
                @folio = Folio.new
                @folio.user_id=current_user.nick
                @folio.gid = params[:input_name]
                @folio.intro = params[:introduce]
                @folio.save
                
                @user = User.find_by_nick(@folio.user_id)
                @user.github=params[:input_name]
                @user.save
                    
                ##############    
                url = "https://github.com/"+@folio.gid
                data = Nokogiri::HTML(open(url))
                
                @lists = data.css('span.repo')
                
                
                @lists.each do |l|
                    @infos = @folio.infos.new
                    @infos.folio_id = @folio.id
                    @infos.gid = @folio.id
                    @infos.list = l.text.strip
                    @infos.save
                    
                    r_url = "https://github.com/"+@folio.gid+"/"+@infos.list+"/blob/master/README.md"
                        begin
                          file = open(r_url)
                            doc = Nokogiri::HTML(file) do
                            # handle doc
                            data = Nokogiri::HTML(open(r_url))
                            readme = data.css('div#readme').at("article[@itemprop = 'text']")
                            rm = @infos.readmes.new
                            rm.readme = readme
                            rm.info_id = @infos.id
                            rm.rid = @infos.id
                            rm.gid = @folio.id
                            rm.save
                          end
                        rescue OpenURI::HTTPError => e
                          if e.message == '404 Not Found'
                            # handle 404 error
                            rm = @infos.readmes.new
                            rm.readme = "등록된 Readme.md 파일이 없습니다."
                            rm.info_id = @infos.id
                            rm.rid = @infos.id
                            rm.gid = @folio.id
                            rm.save
                          else
                            raise e
                          end
                        end    
                        
                    # data = Nokogiri::HTML(open(r_url))
                    # readme = data.css('div#readme').at("article[@itemprop = 'text']")
                    # rm = Readme.new
                    # rm.readme = readme
                    # rm.rid = @infos.id
                    # rm.gid = @folio.id
                    # rm.save
    
                end
                
                ################3
            
              
                url = "https://github.com/"+@folio.gid+"?tab=repositories"
                data = Nokogiri::HTML(open(url))
                @language = data.css('div.f6.text-gray.mt-2')
                @language.each do |lang|
                    # Readme.create(:read => readme.css('span.mr-3').text.strip)
                    #Readme.create(:read => readme.css('article').text.strip)
                    lg = lang.at("span[@itemprop = 'programmingLanguage']")
                    if lg !=nil
                    graph = @folio.graphs.new
                    graph.folio_id = @folio.id
                    graph.gid = @folio.id
                    graph.lang = lg.text
                    graph.save

                    end
                end
                
            
            redirect_to "/folio/#{@folio.user_id}"
      end
      
    end
    
 
    def folio
        uid = params[:user_id].to_s
       
        @folio= Folio.find_by_user_id(uid)
        # s_gid = f.gid
        # @folio = Folio.find_by_gid(s_gid)
        @name = @folio.gid
        @number = @folio.id
        @user = User.find_by_nick(@folio.user_id)
        @experiences=Experience.where(usernick: @folio.user_id)

        @graphs = Graph.where(gid: @folio.id)
        
      # @graphs = Graph.all
        
        @infos = Info.where(gid: @folio.id)
        @readmes = Readme.where(gid: @folio.id)
        
    
    end
    
    def excreate
      @folios=Folio.find_by_user_id(current_user.nick)
      @expost=@folios.experiences.new
      @expost.folio_id = @folios.id
      @expost.usernick=current_user.nick
      @expost.name=params[:name]
      @expost.work=params[:work]
      @expost.start=params[:start]
      @expost.end=params[:end]
      @expost.content=params[:content]
      @expost.save
      

      
      
      redirect_to :back
    end
    
    def delete
      Experience.find(params[:id]).destroy
      redirect_to :back
    end
    
    def update
      @expost=Experience.find(params[:id])
      @expost.usernick=current_user.nick
      @expost.name=params[:name]
      @expost.work=params[:work]
      @expost.start=params[:start]
      @expost.end=params[:end]
      @expost.content=params[:content]
      @expost.save
      
      redirect_to :back
    end  
    
    def intro
    end  
    
    def user
    end
end
