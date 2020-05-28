class Queries {
  //verify users existence
  static String verifyUser({homeless_id}) {
    return '''query verifyUser
    {
      MemberCollection(filter:{homeless_id:"$homeless_id"}){
        homeless_id
        location {
          address
          lat
          lng
        }
        name
        surname
        gender
        age
        dateOfBirth
        joinedDate
        skillLevel
      }
    }''';
  }

  static String getMyHistory({String member_id, String homeless_id}) {
    return '''{
  collection(name:"Transactions",filter:{
    member_id:"$member_id"
  },limit: 5, sort: {
      scanTime: -1,
      }
  )}''';
  }

  /*MemberCollection ( filter: {homeless_id: "$homeless_id"})
  {
    name
    surname
    primary_phoneNumber
    alternative_phoneNumber
  }*/

  //Get location points and place markers
  static String getMarkers({String homeless_id}) {
    return '''query whereAbouts
    {
      MemberCollection(filter:{homeless_id:"$homeless_id"}){
        location {
          address
          lat
          lng
        }
        name
        surname
        
      }
       TransactionsCollection(
         sort: {
      scanTime: -1
      }
      limit: 7
         filter:{homeless_id:"$homeless_id"})
      {
        location {

          lat
          lng
        }
        scanTime
      }
    }''';
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
    language,
    comorbidities,
    homeless_id,
    homeless_name,
    surname,
    joinedDate,
    dateOfBirth,
    age,
    lat,
    lng,
    address,
    residentialMoveInDate,
    // services_needed,
    approximateDateStartedHomeless,
    consent,
    member_name,
    member_id,
    registered_address,
    join_Time,
    registered_lat,
    registered_lng,
    race,
    skillLevel,
    ssn,
    livingSituation,
    disabilityCondition,
    streetNickname,
    primary_phoneNumber,
    alternative_phoneNumber,
    health_Status,
  }) {
    return """mutation addMember
    {
      saveCollectionItem
      (
        name: "Member",
        data:
        {
          homeless_id: "$homeless_id",
          name: "$homeless_name",
          gender: "$gender",
          surname: "$surname",
          language: "$language",
          age: "$age",
          race: "$race",
          joinedDate: "$joinedDate",
          skillLevel: "$skillLevel",
          dateOfBirth: "$dateOfBirth",
          ssn: "$ssn",
          residentialMoveInDate: "$residentialMoveInDate",
          livingSituation: "$livingSituation",
          approximateDateStartedHomeless: "$approximateDateStartedHomeless",
          disabilityCondition: "$disabilityCondition",
          streetNickname: "$streetNickname",
          primary_phoneNumber: "$primary_phoneNumber",
          alternative_phoneNumber: "$alternative_phoneNumber",
          comorbidities: "$comorbidities",
          health_Status: "$health_Status",
          consent: "$consent",
          member_name: "$member_name",
          member_id: "$member_id",
          joinTime: "$join_Time",
          location: {
          address: "$address",
          lat: "$lat",
          lng: "$lng"
          },
          registered_address: {
            address: "$registered_address",
            lat: "$registered_lat",
            lng: "$registered_lng"
          },
        }
      ){
        data
      }
    }""";
  }

  //set The Card to Registered.
  static String registerCard({
    id,
    member_name,
    member_id,
    claimed_Time,
    claimed_Date,
  }) {
    return """mutation registerCard
    {
      saveCollectionItem
      (
        name: "Cards",
        data:
        {
          _id: "$id"
          registered: true,
          member_name: "$member_name",
          member_id: "$member_id",
          claimed_Time: "$claimed_Time",
          claimed_Date: "$claimed_Date",
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
        } MemberCollection (filter: {
              homeless_id: "$homeless_id"
              })
            {
              name
            } 
      }""";
  }

  //view users transactions History
  static String myHistory({member_id, homeless_id}) {
    return '''query myHistory
    {
      TransactionsCollection(filter:{member_id:"$member_id"}, limit: 5){
        homeless_id
        scanTime
        scanDate
      }
      MemberCollection(filter:{homeless_id: "$homeless_id"}) {
        name
        surname
        Primary_phoneNumber
        alternative_phoneNumber
      }
    }''';
  }
}
