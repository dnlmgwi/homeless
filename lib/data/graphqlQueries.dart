class Queries {
  //verify users existence
  static String verifyUser({homeless_id}) {
    return '''{
      collection(name:"Member",
      filter:
      {
        homeless_id:"$homeless_id"
      })}''';
  }

  static String getProjects() {
    return r'''query getProjects{
      ProjectsCollection(
        filter: {
          active: true
        }){
          name
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
  },limit: 5, sort: {
      scanTime: -1,
      })}''';
  }

  static String getMedicalHistory({String homeless_id}) {
    return '''{
  collection(name:"Transactions",filter:{
    homeless_id:"$homeless_id"
    healthcare: true
  },limit: 5, sort: {
      scanTime: -1,
      })
    }''';
  }

  //add a new benefit transaction
  static String addTransaction({
    homeless_id,
    member_id,
    member_name,
    project,
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
          member_name: "$member_name",
          scanDate: "$scanDate",
          scanTime: "$scanTime",
          project: "$project",
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

  //add a news transaction
  static String addMember({
    gender,
    homeless_id,
    name,
    surname,
    joinedDate,
    location,
    dob,
    residentialMoveInDate,
    approximateDateStartedHomeless,
    ethnicity,
    phoneNumber,
    consent,
  }) {
    return """mutation addMember
    {
      saveCollectionItem
      (
        name: "Member",
        data:
        {
          homeless_id: "$homeless_id",
          gender: "$gender",
          name: "$name",
          surname: "$surname",
          joinedDate: "$joinedDate",
          location: {
            address: "$location"
            },
          dob: "$dob",
          residentialMoveInDate: "$residentialMoveInDate",
          approximateDateStartedHomeless: "$approximateDateStartedHomeless",
          
          ethnicity: "$ethnicity",
          phoneNumber: "$phoneNumber",
          
          consent:"$consent"
        }
      ){
        data
      }
    }""";
  }

  //set The Card to Registered.
  static String registerCard({id}) {
    return """mutation registerCard
    {
      saveCollectionItem
      (
        name: "Cards",
        data:
        {
          _id: "$id"
          registered: true,
        }
      ){
        data
      }
    }""";
  }

  //Checks if the card is Registered if True, who is regsistred to it if false Begin Regsitration.
  static String registrationProcess({String homeless_id}) {
    return """query RegistrationProcess
    {
      CardsCollection(
        filter:
        {
          homeless_id: "$homeless_id"
        })
        {
          registered
          _id
        } collection(name: "Cards",
            filter:
            {
              homeless_id: "$homeless_id"
            })
            MemberCollection (filter: {
              homeless_id: "$homeless_id"
              })
            {
              homeless_id
              name
            } TransactionsCollection (limit: 1)
            {
              scanTime
            }
      }""";
  }
}
