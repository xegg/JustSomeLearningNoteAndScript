:{
    let { g op n [] = n
    ; g op n (h:t) = h `op` g op n t
    }
:}

:set +t --可以看到每个变量的类型
:set +mj
