(require '[clojure.string :as str])

(let
  [lines (str/split-lines (slurp "input.txt"))
   rules (map #(str/split % #" -> ") (rest (rest lines)))]
  (do
    (def start (first lines))
    (def rules (into {} rules))
  )
)


(defn counter [list]
  (reduce
    (fn [acc, elem]
      (assoc acc elem (inc (get acc elem 0)))
    )
    {}
    list
  )
)


(defn apply-rule [occurences, new-occurences, rule]
  (let [
    [left, right] (map first (split-at 1 (first rule)))
    left (str left (last rule))
    right (str (last rule) right)
  ]
  (if (contains? occurences (first rule))
    (let [
      amount (get occurences (first rule))
      with-left (assoc new-occurences left (+ amount (get new-occurences left 0)))
      with-right (assoc with-left right (+ amount (get with-left right 0)))
    ] with-right)
    new-occurences
  )
))

(defn step [occurences, rules, n]
  (let
    [new-occurences (reduce #(apply-rule occurences %1 %2) {} rules)]
    new-occurences
  )
)


(defn eval-part [start rules steps]
  (let
    [parsed-keys (map #(str/join "" %) (partition 2 1 start))
     occurences (counter parsed-keys)

     sequence (reduce #(step %1 rules %2) occurences (range steps))
     occured-letters (reduce (fn [acc, [k, v]] (assoc acc (first k) (+ v (get acc (first k) 0)))) {} sequence)
     occured-letters (assoc occured-letters (last start) (inc (get occured-letters (last start) 0)))]
    (- (apply max (vals occured-letters)) (apply min (vals occured-letters)))
  )
)

(do
  (print "[Part1] ") (println (eval-part start rules 10))
  (print "[Part2] ") (println (eval-part start rules 40))
)