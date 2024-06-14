import Map "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";

actor {
    type Entry = {
        plantName : Text;
        updatedTime : Text;
        timeZone : Text;
        productionPower : Nat;
        consumptionPower : Nat;
        gridPower : Nat;
    };

    var nextId : Nat = 0;

    func natHash(n : Nat) : Hash.Hash {
        Text.hash(Nat.toText(n));
    };

    let performanceLogs = Map.HashMap<Nat, Entry>(0, Nat.equal, natHash);

    public func inserEntryt(entry : Entry) : async () {
        let id = nextId;
        performanceLogs.put(id, entry);
        nextId += 1;
    };

    public query func getEntryById(id : Nat) : async ?Entry {
        performanceLogs.get(id);
    };

    public query func getAllEntries() : async [Entry] {
        return Iter.toArray(performanceLogs.vals());
    };

};
