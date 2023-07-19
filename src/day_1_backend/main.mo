import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Nat32 "mo:base/Nat32";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

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

  public query func trim_whitespace(t: Text): async Text {
    var trimmed_text = "";
    for (char in t.chars()) {
      if (char != ' ') {
        trimmed_text #= Char.toText(char);
      };
    };
    return trimmed_text;
  };

  // public query func duplicated_character(t: Text): async Text {
  //   var text = t;
  //   let len = t.size();
  //   var characters: [Char] = [];
  //   for (char in t.chars()) {
  //     characters := Array.append<Char>(characters, [char]);
  //   };
  //   Debug.print(debug_show(characters));
  //   // for (index in Iter.range(0, len-2)) {
  //   //   if (text[index] == text[index+1]) {
  //   //     return text[index];
  //   //   };
  //   // };
  //   return t;
  // };

  public query func swap(arr: [Nat], i: Nat, j: Nat): async [Nat] {
    let mutable_arr = Array.thaw<Nat>(arr);
    mutable_arr[i] := arr[j];
    mutable_arr[j] := arr[i];
    return Array.freeze<Nat>(mutable_arr);
  };

  public query func init_count(n: Nat): async [Nat] {
    let arr = Array.init<Nat>(n, 0);
    var counter = 0;
    for (val in arr.vals()) {
      arr[counter] := counter;
      counter += 1;
    };
    return Array.freeze<Nat>(arr);
  };

  public query func seven(arr: [Nat]): async Text {
    for (val in arr.vals()) {
      if (val == 7) {
        return "Seven is found";
      };
    };
    return "Seven not found";
  };

  public query func nat_opt_to_nat(n: ?Nat, m: Nat): async Nat {
    switch(n) {
      case (?n) return n;
      case (_) return m;
    };
  };

  public query func day_of_the_week(n: Nat): async ?Text {
    switch(n) {
      case (1) return ?"Monday";
      case (2) return ?"Tuesday";
      case (3) return ?"Wednesday";
      case (4) return ?"Thursday";
      case (5) return ?"Friday";
      case (6) return ?"Saturday";
      case (7) return ?"Sunday";
      case (_) return null;
    };
  };

  // public query func populate_array(arr: [?Nat]): async [Nat] {
  //   Array.map<?Nat, Nat)>(arr, func(x) {
  //     switch(x) {
  //       case (?x) return x;
  //       case (_) return 0;
  //     };
  //   });
  // };

  // public query func sum_of_array(arr: [Nat]): async Nat {
  //   for 
  // };

  public shared ({caller}) func is_anonymous(): async Bool {
    return caller == Principal.fromText("2vxsx-fae");
  };

  let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

  public shared ({caller}) func add_favorite_number(n: Nat): async () {
    favoriteNumber.put(caller, n);
  };

  public query func show_favorite_number(): async ?Nat {
    
  };
};
