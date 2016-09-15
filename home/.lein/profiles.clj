{:user {:plugins [[lein-kibit "0.1.2"]
                  ;;[lein-deps-tree "0.1.2"]
                  [lein-try "0.2.0"]
                  ;;[lein-autoreload "0.1.0"]
                  [jonase/eastwood "0.2.3"]
                  [lein-ancient "0.6.8"]
                  [lein-bikeshed "0.1.3"]
                  [slamhound "1.5.5"]
                  [lein-cloverage "1.0.6"]]
        :aliases {"omni"
                  ["do" 
                   ["clean"]
                   ["with-profile" "production" "deps" ":tree"]
                   ["ancient"]
                   ["kibit"]
                   ["bikeshed"]]
                  "slamhound"
                  ["run" "-m" "slam.hound"]}
        }}
