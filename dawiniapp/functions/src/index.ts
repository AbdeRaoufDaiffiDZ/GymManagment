import * as functions from "firebase-functions";
import admin = require("firebase-admin");


admin.initializeApp({
  databaseURL:
    "https://dawini-cec17-default-rtdb" +
    ".europe-west1.firebasedatabase.app/",
  credential: admin.credential.cert({
    clientEmail: "firebase-adminsdk-r" +
      "xmpe@dawini-cec17.iam.gserviceaccount.com",
    privateKey: "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgk" +
      "qhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC3VqpPbhnG8/pO\nHNOrsjWE" +
      "7IUFvTywbE0H6dUr3DhhT05WOdMXRmxjqE/QiaMqxiMhT0IZ0n" +
      "Og/b5C\nDXiFvzuy2jW6ooCGD7UCSflfKzDzsVuZ1Chn2b/ROY" +
      "R6Epd22Tg881u/oRjW+Dnw\nkGiZBMHMPQgoc0uZsJnINXs21Tc" +
      "lhViG1/5OU0abOzzp6j5ejb2I8nZYNP4DOnHv\nX2O2y8AXZvbh" +
      "lWExmtZs6Xgq8DhOqpz5oJbSoknkuc9BvD5dlcUHZsaP/ehIbhm+" +
      "\nrBIqLsp4Y/nMCeVN+8/GQaAobG0ld8t9Fo3g70IQn3P7A09hXU" +
      "KBlmcFYo1GX6v0\nu017GGPZAgMBAAECggEAFz8//S5iyl1pYb" +
      "o6BM1mB+LNwzqJlX1GDzjRNOyJoZ0i\nu8A9Sfg+CizvYevx6p" +
      "yRG8onAYsz6jgChfGbVKo48abFpVKxpU4cj5u9qRma7WuR\nx+G" +
      "k9fYgYnE+oRP2bLWCcggRnCzbL3buMdi9yplV0YXzoN1tuqEv/r" +
      "j5VKyYf4M/\nuz6wQ9gIydj4LX4ASopK3ETaJfU1sqswexzIRyC" +
      "F0E822MQN8e7/MbUvDJYBIhpa\nJrwgHFF7H8tVGjML3U8KDbQg" +
      "taJKZh8ULEhxkYUBDSyyFgEHApGAguIRXhXiUUL0\nDhujtqDJJ" +
      "J0cPyurz620li2Q//tiIW+jKMut3fQC+QKBgQDyToG0Nl8Mav3W" +
      "tVi5\nR088a0ogJ4YLZ3SqaDnKCarPXLrM2xS6cr9nO5IQQ88cQ" +
      "4X3PEgwHYIXxI2Th6B3\nZi2Hc+A2bx29fOq2q8OoUxyckGu43m" +
      "m72YW084FD6N+Dw3gaIOEgnjmzJgx6ymfR\n5TZViOv1QlXdKju" +
      "TrEuo9LFA3wKBgQDBsw5nGL7puePAk6GLunAPLVDlSoTQubBd\n" +
      "THPtt/Kj7zJCTSTzNQA+b38vKjFiR0r2ayVMYqOh6cE/EYg2mO1" +
      "non3srYGXSCvj\nXuswyb69BsimYepvdY36KCDmQWv/hyxxzhP6" +
      "CXSv9YiIzMwyB5iXtAZVfuTxw3zc\nMomvMf9aRwKBgEEjXbbmj" +
      "vK1qHuZ0LouM1zYstqmBWD3dOOClVZ89tA763O6yX29\n7zp/Ry" +
      "rcL8c3V8I5EGbu59Qf4LdyVG8EpuSs/+9iO6p+9FIbJsQPY7erE" +
      "2plUCNR\nvKICfBOXfM7dM2JCyIKORpCkf+Jam0JPziV8Y4JRTO" +
      "fhvJZcURKghS4dAoGBAINF\nlUo7lA8UgwydQMtQg+dVP9DVSuO" +
      "mJKdmS97cXl3JmtciLxuAXPTzXU+ambNQO7Z6\n8OEurFTr9aKH" +
      "gDf4NlSY5ByFjiD3sX67ckszPsgek9dm3pnBIoJZtco2pjmb43w" +
      "R\nPKqkw+cIUQrdOLnjOf/96pkAkapjYPhea79G9Ba7AoGAHZ+A" +
      "NCRx2aU13k2dGsri\nNr3eCLwM/zkSy7tzGOjb5/KWSa6yR6dt7" +
      "3zAk8n02auGGb+tFpQ8jOEJ9bMYOjdb\nCgNjsHzUDf50Fw8Dlg" +
      "7O4GfR2f/PuvuvbjlFPzSj+PSC/fPv19hlnF4qwnS+pr7/\nkNE" +
      "spbO+/Nydnf5wNh1vc5I=\n-----END PRIVATE KEY-----\n",
    projectId: "dawini-cec17",
  }),
});
/**
 * This function formats the current date in YYYY-MM-DD format.
 * @return {string} The formatted date string in YYYY-MM-DD format.
 */
function getTodayDate(): string {
  const today = new Date();
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, "0");
  const day = String(today.getDate())
    .padStart(2, "0");
  return "" + year + "-" + month + "-" + day;
}
interface Patient {
  token: string;
  turn: number;
}
exports.readSpecificDocument = functions.database.ref("/doctorsList")
  .onUpdate(async (change, context) => {
    const afterData = change.after.val();
    const filteredDoctors = afterData.filter((obj: object) => obj !== null);
    if (!filteredDoctors) {
      return;
    }
    for (const objj of filteredDoctors) {
      const doctorUid = objj.uid;
      const newTurn = objj.turn; // Assuming "currentTurn" holds the new turn
      // Check if newTurn exists and avoid processing empty objects
      if (!newTurn) {
        console.warn("Skipping update for doctor:",
          doctorUid, "due to missing newTurn");
        continue;
      }
      const docRef = admin.database().ref("/user_data/Doctors/" + doctorUid +
      "/Cabin_info/Patients/" + getTodayDate());
      const snapshot = await docRef.once("value");
      const filteredData = snapshot.val()?.
        filter((obj: object) => obj !== null);
      if (!filteredData) {
        console.warn("No patients found for Dr.", doctorUid);
        return;
      }
      for (const obj of filteredData as Patient[]) {
        const token = obj.token;
        const patientTurn = obj.turn;
        if (patientTurn - 2 === newTurn) {
          const payload: admin.messaging.MessagingPayload = {
            notification: {
              title: "اقترب دورك عند الطبيب " + objj.lastName,
              body: "الطبيب في انتظارك دورك بعد مريضين من الان",
            },
          };
          await admin.messaging().
            sendToDevice(token, payload);
        } else if (patientTurn - 1 === newTurn) {
          const payload: admin.messaging.MessagingPayload = {
            notification: {
              title: "اقترب دورك عند الطبيب " + objj.lastName,
              body: "الطبيب في انتظارك، دورك هو التالي",
            },
          };
          await admin.messaging().
            sendToDevice(token, payload);
        }
      }
    }
  });
type DataSnapshotValue = any | null;

exports.updateStateMaxNumber = functions.database.ref("/user_data/Doctors")
  .onUpdate(async (change, context) => {
    // debugger;
    const data = admin.database().ref("/doctorsList");
    const snapshot = await data.once("value");
    const filteredData = snapshot.val()?.
      filter((obj: object) => obj !== null);
    if (!filteredData) {
      console.warn("No doctor found for Dr.");
      return;
    }
    for (const obj of filteredData) {
      const maxNumber = obj.max_number;
      const doctorUid = obj.uid;
      const cabinRef = admin.database().ref("/user_data/Doctors/" + doctorUid);
      const PatientRef = cabinRef.child("/Cabin_info/Patients/" +
        getTodayDate());
      const snapshotPatient = await PatientRef.
        once("value");
      const snapshotDoctors = await cabinRef.once("value");
      const filteredDoctors = snapshotDoctors.val();
      const filteredPatients: DataSnapshotValue[] = snapshotPatient.val()?.
        filter(
          (data: object): data is object => data !== null
        ) || []; // Set default to empty array

      const numPatients = filteredPatients.length;


      if (maxNumber <= numPatients) {
        console.log("updated");

        const doctorData = data.child("/" +
          obj.numberInList);
        doctorData.update({
          firstNameArabic: obj.firstNameArabic,
          lastNameArabic: obj.lastNameArabic,
          specialityArabic: obj.specialityArabic,
          ImageProfileurl: obj.ImageProfileurl,
          numberOfPatient: numPatients,
          location: obj.location,
          date: obj.date,
          experience: obj.experience,
          max_number: obj.max_number,
          lastName: obj.lastName,
          firstName: obj.firstName,
          phoneNumber: obj.phoneNumber,
          turn: obj.turn,
          speciality: obj.speciality,
          atSerivce: false,
          Wilaya: obj.Wilaya,
          city: obj.city,
          uid: obj.uid,
          recommanded: obj.recommanded,
        });
        cabinRef.update({
          firstNameArabic: obj.firstNameArabic,
          lastNameArabic: obj.lastNameArabic,
          specialityArabic: obj.specialityArabic,
          ImageProfileurl: obj.ImageProfileurl,
          numberOfPatient: numPatients,
          location: obj.location,
          date: obj.date,
          experience: obj.experience,
          max_number: obj.max_number,
          lastName: obj.lastName,
          firstName: obj.firstName,
          phoneNumber: obj.phoneNumber,
          turn: obj.turn,
          speciality: obj.speciality,
          isWorking: false,
          Wilaya: obj.Wilaya,
          city: obj.city,
          uid: obj.uid,
          recommanded: obj.recommanded,
          Cabin_info: filteredDoctors.Cabin_info, //
        });
      }
    }
  });
