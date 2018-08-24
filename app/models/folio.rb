class Folio < ActiveRecord::Base
    
    has_many :infos, :dependent => :destroy
    has_many :graphs, :dependent => :destroy
    has_many :experiences, :dependent => :destroy
    
end

