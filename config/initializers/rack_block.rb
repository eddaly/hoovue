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
                                       
                                       ip_pattern '91.194.84.' do
                                           halt 401
                                            end
                                            
                                            ip_pattern '180.76.5.' do
                                                halt 401
                                                 end
                                       
                                                 ip_pattern '74.112.202.' do
                                                     halt 401
                                                      end
                                       
                                                  ip_pattern '5.9.73.' do
                                                     halt 401
                                                      end

                                                       ip_pattern '69.30.238.' do
                                                     halt 401
                                                      end




                                                      
                                      
                                   
  end

end

