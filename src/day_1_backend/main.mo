import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Nat32 "mo:base/Nat32";

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

  public query func nat_to_nat8(n: Nat): async Nat8 {
      if(n > 255) { 
          return 0; // n is too big to be representend by a Nat8, returning 0 is a personal choice you could return basically anything maybe 255 makes more sense.
      } else {
          return Nat8.fromNat(n);
      };  
  };

  public query func max_number_with_n_bits(n: Nat): async Nat {
    return 2**(n)-1;
  };

  public query func decimal_to_bits(n: Nat): async Text {
    var m = n;
    var bits = "";
    while (m > 0) {
      let rem = m % 2;
      if (rem == 1) {
        bits := "1" # bits;
      } else {
        bits := "0" # bits;
      };
      m := m / 2;
    };
    return bits;
  };

  public query func capitalize_character(c: Char): async Char {
    let ascii_code = Char.toNat32(c);
    if (ascii_code >= 97 and ascii_code <= 122) {
      return (Char.fromNat32(ascii_code - 32));
    };
    return (Char.fromNat32(ascii_code));
  };

  public query func is_inside(t: Text, c: Char): async Bool {
    for (char in t.chars()) {
      if (char == c) {
        return true;
      };
    };
    return false;
  };
};
