class Queries {
  //verify users existence
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
      lat
      lng
      } 
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

  //add a news transaction
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
  static String addMember(
      {gender,
      name,
      surname,
      joinedDate,
      location,
      dob,
      residentialMoveInDate,
      approximateDateStartedHomeless,
      race,
      ethnicity,
      phoneNumber,
      services_needed,
      consent}) {
    return """mutation addMember
    {
      saveCollectionItem
      (
        name: "Member",
        data:
        {
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
          race: "$race",
          ethnicity: "$ethnicity",
          phoneNumber: "$phoneNumber",
          Services_needed: "$services_needed",
          consent:"$consent"
        }
      ){
        data
      }
    }""";
  }
}
