(herald "PAKE 0")
  
(defprotocol ns basic
	(defrole init
	(vars (P Q name)(r s m text)(p skey))
	(trace 
		(send r)
		(recv s)
		(send (enc m (hash p P Q r s)))))
	(defrole resp
	(vars (r s text)(p skey)(d data))
	(trace	
		(recv r)
		(send s)
		(recv d))))
		
(defskeleton ns
 (vars (P Q name)(r s m text)(p skey))
 (defstrand init 3  (P P)(Q Q)(m m)(s s)(r r))
 (deflistener p)
 (deflistener m)
 (uniq-orig r)
 (pen-non-orig p))
 
(defskeleton ns
 (vars (s m text)(d data))
 (defstrand resp 3  (d d)(s s))
 (deflistener m)
 (uniq-orig s))
 
 (defskeleton ns
 (vars (P Q name)(r s m text)(p skey)(d data))
 (defstrand init 3  (P P)(Q Q)(m m)(s s)(r r))
 (defstrand resp 3  (d d)(s s))
 (deflistener (hash p P Q r s))
 (uniq-orig r s m)
 (pen-non-orig p))