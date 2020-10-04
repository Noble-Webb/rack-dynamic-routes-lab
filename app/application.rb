# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message

class Application
    @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]
    
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            #if the requested path is items
            item = req.path.split("/items/").last
            #splits to just the item name
            if item_name = @@items.find{|i| i.name == item}
                #if you find an item name
                resp.write item_name.price
                #tell the user the price  
            else
                #if item name not found
                resp.write "Item not found"
                #tell user ^^
                resp.status = 400
                #set the status to 400
            end
        else
            #if the path is not items
            resp.write "Route not found"
            #tell user ^^
            resp.status = 404
            #set the status to 404
        end

        resp.finish
    end
end