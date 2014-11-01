module Convoy
    INTERNAL_ERROR_EXIT_CODE = 1
    CLIENT_ERROR_EXIT_CODE = 2
    USER_ERROR_EXIT_CODE = 3
    EXTERNAL_ERROR_EXIT_CODE = 10

    #module to tag all exceptions coming out of Convoy with
    module Error
    end

    #all our exceptions will supported nesting other exceptions
    #also all our exception will be a kind_of? Convoy::Error
    class BaseError < StandardError
        include Nesty::NestedError
        include Error
    end

    #user did something invalid
    class UserError < BaseError
    end

    #for errors with convoy itself
    class InternalError < BaseError
    end

    #for errors with how convoy is being used
    class ClientError < BaseError
    end

    #a dependency is temporarily unavailable
    class TransientError < BaseError
    end
end
