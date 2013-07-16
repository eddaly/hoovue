class Ability
  include CanCan::Ability

  def initialize(user)
    if @current_user
      user = @current_user
    else
       user ||= User.new # guest user (not logged in)
     end
        if user.googleplus == "lecrabe"
          can :manage, :all  
          can :destroy, :all
          can :access, :rails_admin   
          can :dashboard              
        end
        
        if user.role == "user"
            can :read, :all  
              can :manage, User, :id => user.id
                cannot :destroy, User
                  can [:create, :flag, :increase], Credit
                    can :manage, Credit, :user_id => user.id
                      can :create, Product
                        can :manage, Product, :user_id => user.id
                          can :manage, CreditValidation
                          can :access, :rails_admin   
                            cannot :dashboard 
                            cannot [:create, :destroy], Email, :user_id => user.id
                
        end
        if user.role.nil?
          cannot :manage, :all
            can :read, :all  
       end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
