class FolioController < ApplicationController
  def folio
   @graphs =Graph.all
  end
end
