class SalesController < ApplicationController
    def index
        @sales = Sale.where(year: '2023')
    end
end
