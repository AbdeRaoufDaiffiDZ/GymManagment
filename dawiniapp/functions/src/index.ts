// Import required libraries
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Interface for doctorEntity (replace with your actual properties)


// Initialize Firebase Admin app (replace with your credentials)
admin.initializeApp();

// Get a database reference
const database = admin.database();
// /**
//  *  Formats a date in yyyy-mm-dd format.
//  *  @param {Date} date The date object to format.
//  *  @return {string} The formatted date string in yyyy-mm-dd format.
//  */
// function formatDate(date: Date): string {
//   const year = date.getFullYear().toString().padStart(4, "0");
//   const month = (date.getMonth() + 1).toString().padStart(2, "0");
//   const day = date.getDate().toString().
//     padStart(2, "0");

//   return `${year}-${month}-${day}`;
// }
export const getDoctorList = functions.https.onCall(async () => {
  // Get a reference to the doctors list
  // Get today's date
  // const today = new Date();

  // Format the date
  // const formattedDate = formatDate(today);
  const doctorsRef = database.ref("/doctorsList");

  // Get a snapshot of the list data
  const snapshot = await doctorsRef.once("value");
  // Check if data exists
  if (snapshot.exists()) {
    console.log("Data found!");
    // Process the data from snapshot.val()
  } else {
    console.log("No data found at the specified path.");
    // Handle the case where no data exists
  }

  return "Data read operation completed.";

  // // Get the list value (an object)
  // const listData = snapshot.val() as { [key: string]: DoctorEntity };

  // // Convert list data to an array of DoctorEntity objects
  // const doctorList: DoctorEntity[] = Object.values(listData);

  // // Access and process doctor data (replace with your logic)
  // doctorList.forEach( async (doctor) => {
  //   const patientssRef = database.ref("/user_data/Doctors/"+
  //   doctor.uid +"/Cabin_info/Patients/" + formattedDate);
  //   const snap = await patientssRef.once("value");
  //   const listDataPatient = snap.val() as { [key: string]: PatientEntity };
  //   const patientList: PatientEntity[] = Object.values(listDataPatient);
  //   patientList.forEach((patient) => {
  //     if (patient.turn == doctor.turn) {
  //       console.log("patient name is: "+ patient.firstName);
  //     }
  //   });
  // });

  // return doctorList;// Return the list of doctors
});
// interface DoctorEntity {
//   numberOfPatient: Int32Array,
//   uid: string,
//   firstName: string,
//   lastName: string,
//   phoneNumber: string,
//   wilaya: string,
//   city: string,
//   speciality: string,
//   atSerivce: boolean,
//   turn: Int32Array,
//   location: string,
//   date: string,
//   experience: string,
//   description: string,
//   numberInList: Int32Array
//   // Add other doctor properties
// }
// interface PatientEntity {
//   firstName:string,
//   today:boolean,
//   gender:string,
//   lastName:string
//   phoneNumber:string,
//   address:string
//   age:string
//   AppointmentDate:string
//   turn:Int32Array,
//   DoctorName:string;
//   uid:string;
//   token:string
// }
