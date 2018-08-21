# require 'nokogiri'
# require 'open-uri'

# class FolioController < ApplicationController
    
    
#     def index
        
#     end
    
#     def create
        
#         f = Folio.find_by_gid(params[:input_name])
#         if f.nil?
#                 @folio = Folio.new
#                 @folio.gid = params[:input_name]
#                 @folio.save
                    
                    
#                 ##############    
#                 url = "https://github.com/"+@folio.gid
#                 data = Nokogiri::HTML(open(url))
#                 @lists = data.css('span.repo')
                
                
#                 @lists.each do |l|
#                     @infos = Info.new
#                     @infos.gid = @folio.id
#                     @infos.list = l.text.strip
#                     @infos.save
                    
#                     r_url = "https://github.com/"+@folio.gid+"/"+@infos.list+"/blob/master/README.md"
#                         begin
#                           file = open(r_url)
#                             doc = Nokogiri::HTML(file) do
#                             # handle doc
#                             data = Nokogiri::HTML(open(r_url))
#                             readme = data.css('div#readme').at("article[@itemprop = 'text']")
#                             rm = Readme.new
#                             rm.readme = readme
                            
#                             rm.rid = @infos.id
#                             rm.gid = @folio.id
#                             rm.save
#                           end
#                         rescue OpenURI::HTTPError => e
#                           if e.message == '404 Not Found'
#                             # handle 404 error
#                             rm = Readme.new
#                             rm.readme = "등록된 Readme.md 파일이 없습니다."
#                             rm.rid = @infos.id
#                             rm.gid = @folio.id
#                             rm.save
#                           else
#                             raise e
#                           end
#                         end    
                        
#                     # data = Nokogiri::HTML(open(r_url))
#                     # readme = data.css('div#readme').at("article[@itemprop = 'text']")
#                     # rm = Readme.new
#                     # rm.readme = readme
#                     # rm.rid = @infos.id
#                     # rm.gid = @folio.id
#                     # rm.save
    
#                 end
                
#                 ################3
            
              
#                 url = "https://github.com/"+@folio.gid+"?tab=repositories"
#                 data = Nokogiri::HTML(open(url))
#                 @language = data.css('div.f6.text-gray.mt-2')
#                 @language.each do |lang|
#                     # Readme.create(:read => readme.css('span.mr-3').text.strip)
#                     #Readme.create(:read => readme.css('article').text.strip)
#                     lg = lang.at("span[@itemprop = 'programmingLanguage']")
#                     if lg !=nil
#                     graph = Graph.new
#                     graph.gid = @folio.id
#                     graph.lang = lg.text
#                     graph.save
                    
#                     end
#                 end
                
            
#             redirect_to "/folio/folio/#{@folio.id}"
             
#         else redirect_to "/folio/folio/#{f.id}"
#         end
#     end
    
#     def folio
#         @folio = Folio.find(params[:id])
#         @name = @folio.gid
#         @number = @folio.id
 
#         @graphs = Graph.where(gid: params[:id])
        
#       # @graphs = Graph.all
        
#         @infos = Info.where(gid: params[:id])
#         @readmes = Readme.where(gid: params[:id])
    
#     end
# end



require 'nokogiri'
require 'open-uri'

class FolioController < ApplicationController
    
    
    def index
        
    end
    
    def create
        
        f = Folio.find_by_gid(params[:input_name])
        if f.nil?
                @folio = Folio.new
                @folio.gid = params[:input_name]
                @folio.save
                    
                    
                ##############    
                url = "https://github.com/"+@folio.gid
                data = Nokogiri::HTML(open(url))
                @lists = data.css('span.repo')
                
                
                @lists.each do |l|
                    @infos = Info.new
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
                            rm = Readme.new
                            rm.readme = readme
                            
                            rm.rid = @infos.id
                            rm.gid = @folio.id
                            rm.save
                          end
                        rescue OpenURI::HTTPError => e
                          if e.message == '404 Not Found'
                            # handle 404 error
                            rm = Readme.new
                            rm.readme = "등록된 Readme.md 파일이 없습니다."
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
                    graph = Graph.new
                    graph.gid = @folio.id
                    graph.lang = lg.text
                    graph.save

                    end
                end
                
            
            redirect_to "/folio/#{@folio.gid}"
             
        else redirect_to "/folio/#{f.gid}"
        end
    end
    
    def folio
        
        s_gid = params[:gid].to_s
        @folio = Folio.find_by_gid(s_gid)
        @name = @folio.gid
        @number = @folio.id

        @graphs = Graph.where(gid: @folio.id)
        
      # @graphs = Graph.all
        
        @infos = Info.where(gid: @folio.id)
        @readmes = Readme.where(gid: @folio.id)
    
    end
end
