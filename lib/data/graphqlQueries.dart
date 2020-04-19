class Queries {
  //verify users excistance
  static String verifyUser() {
    return r'''query checkMember($_id: String!) {
    MemberCollection(_id: $_id)
    {
      name
      _id
      surname
      age
      gender
      joinedDate
      picture {
        path
      }
      location {
      address
      }
    }
    }''';
  }

//Get Recent News most recent
  static String getNews() {
    return r'''query loadNews {
      NewsCollection(
      sort: {
      posted: -1,
      }, limit: 10)
      {
        image {
          path
          meta
          }
        title
        source
        author
        description
        content
        posted
      }
  }''';
  }

// Users Transaction History
  static String getTransactionHistory({String homeless_id}) {
    return '''{
  collection(name:"Transactions",filter:{
    homeless_id:"$homeless_id"
  },limit: 5)
}''';
  }

  //add a news transaction
  static String addTransaction({
    homeless_id,
    member_id,
    scanDate,
    scanTime,
    address,
    lat,
    lng,
    bool healthcare,
    bool food,
    bool accommodation,
  }) {
    return """mutation addTransaction
    {
      saveCollectionItem
      (
        name: "Transactions",
        data:
        {
          homeless_id: "$homeless_id",
          member_id: "$member_id",
          scanDate: "$scanDate",
          scanTime: "$scanTime",
          location: {
            address: "$address",
            lat: "$lat",
            lng: "$lng"
          },
          
          healthcare: "$healthcare",
          food: "$food",
          accommodation: "$accommodation",
        }
      ){
        data
      }
    }""";
  }
}
