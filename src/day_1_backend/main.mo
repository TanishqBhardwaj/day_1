import Array "mo:base/Array";

actor {
  public query func add(n : Nat, m: Nat) : async Nat {
    return n + m;
  };

  public query func square(n: Nat): async Nat {
    return n*n;
  };

  public query func days_to_second(n: Nat): async Nat {
    return n * 24 * 60 * 60;
  };

  var counter = 0;
  public query func increment_counter(n: Nat): async Nat {
    counter += n;
    return counter; 
  };

  public query func clear_counter(): async Nat {
    counter:= 0;
    return counter;
  };

  public query func divide(m: Nat, n: Nat): async Bool {
    return m % n == 0;
  };

  public query func is_even(n: Nat): async Bool {
    return n % 2 == 0;
  };

  public query func sum_of_array(arr: [Nat]): async Nat {
    var sum = 0;
    for (val in arr.vals()) {
      sum += val;
    };
    return sum;
  };

  public query func maximum(arr: [Nat]): async Nat {
    var max = 0;
    for (val in arr.vals()) {
      if (max < val) {
        max := val;
      };
    };
    return max;
  };

  public query func remove_from_array(arr: [Nat], n: Nat): async [Nat] {
    var new_arr : [Nat] = [];
    for (val in arr.vals()) {
      if (val != n) {
        new_arr := Array.append(new_arr, [val]);
      };
    };
    return new_arr;
  };

  private func _swap(arr: [Nat], i: Nat, j: Nat): [Nat] {
    let arr_mutable = Array.thaw<Nat>(arr);
    let temp = arr_mutable[i];
    arr_mutable[i] := arr_mutable[j];
    arr_mutable[j] := temp;
    return (Array.freeze<Nat>(arr_mutable));
  };

  public query func selection_sort(arr: [Nat]): async [Nat] {
    var sorted = arr;
    let size = arr.size();
    for (i in Iter.range(0, size - 1)) {
      var curr_min = i;
      for (j in Iter.range(i, size - 1)) {
        if (sorted[j] < sorted[curr_min]) {
          curr_min := j;
        };
      };
      sorted := _swap(sorted, curr_min, i);
    };
    return (sorted);
  };
};
