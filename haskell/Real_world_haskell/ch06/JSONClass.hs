type JSONError = String

class JSON a where
    toJValue :: a -> Jvalue
    fromJValue :: JValue -> Either JSONError a


