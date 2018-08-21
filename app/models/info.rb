class Info < ActiveRecord::Base
    
    belongs_to :folio
    has_many :readmes, :dependent => :destroy
end
