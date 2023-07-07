actor {
  public query func add(n : Nat, m: Nat) : async Nat {
    return n + m;
  };

  public query func square(n: Nat): async Nat {
    return n*n;
  }
};
