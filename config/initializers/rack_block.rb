Hoo::Application.configure do

  config.middleware.insert_before(Rack::Lock, Rack::Block) do  
    ip_pattern '5.10.83.' do
        halt 401
         end
         
         ip_pattern '198.143.175.' do
             halt 401
              end
              
              ip_pattern '198.143.175.122' do
                  halt 401
                   end
                   
                   ip_pattern '208.115.113.' do
                       halt 401
                        end
                        
                        ip_pattern '192.187.115.' do
                            halt 401
                             end
                             
                             ip_pattern '199.233.' do
                                 halt 401
                                  end
                                  
                                  ip_pattern '144.76.95.' do
                                      halt 401
                                       end
  end

end

