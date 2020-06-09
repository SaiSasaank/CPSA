(herald "Apple i-Message")


(defprotocol ns basic
 (defrole init
 (vars (a b name)(m text)(k skey))
  (trace
   (send (cat
			(enc k (pubk b))
			(enc m k)
			(enc (enc k (pubk b)) (enc m k) (privk a)) 
			(hash (enc k (pubk b)) (enc m k) (enc (enc k (pubk b)) (enc m k) (privk a)))
			(enc (hash (enc k (pubk b)) (enc m k) (enc (enc k (pubk b)) (enc m k) (privk a))) k)
			))))
  
(defrole response
  (vars (a b name)(m text)(k skey))
  (trace 
   (recv (cat
			(enc k (pubk b))
			(enc m k)
			(enc (enc k (pubk b)) (enc m k) (privk a)) 
			(hash (enc k (pubk b)) (enc m k) (enc (enc k (pubk b)) (enc m k) (privk a)))
			(enc (hash (enc k (pubk b)) (enc m k) (enc (enc k (pubk b)) (enc m k) (privk a))) k)
			)))))

(defskeleton ns
 (vars (a b name)(m text)(k skey))
 (defstrand init 1  (b b)(a a)(m m)(k k))
 (deflistener (enc m k))
 (deflistener (enc k (pubk b)))
 (non-orig (privk a)(privk b))
 (uniq-orig k))
 
(defskeleton ns
 (vars (a b name)(m text))
 (defstrand response 1  (b b)(a a)(m m))
 (non-orig (privk a)(privk b)))
 
(defskeleton ns
 (vars (a b a-0 name)(m text)(k skey))
 (defstrand response 1  (b b)(a a-0)(m m))
 (defstrand init 1  (b b)(a a)(m m)(k k))
 (non-orig (privk a)(privk b))
 (uniq-orig m k))