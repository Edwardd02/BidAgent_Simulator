classdef Product
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        actualPrice
        productId
        productName
    end
    
    methods
        function obj = Product(productId, productName, actualPrice)
            obj.actualPrice = actualPrice;
            obj.productId = productId;
            obj.productName = productName;
        end

    end
end

