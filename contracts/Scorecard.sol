// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Scorecard {
    uint256 studentsCount = 0;
    address public classTeacher;

    constructor () {
        classTeacher = msg.sender;
    }
    modifier onlyClassTechaer(address _classTeacher){
        require(classTeacher == _classTeacher, "only class teacher has access to this function");
        _;
    }
    struct StudentDetails {
        string firstName;
        string lastName;
        uint256 studentId;
    }

    struct Score {
        uint256 studentId;
        uint256 englishMarks;
        uint256 mathsMarks;
        uint256 sciencemMarks;
    }

    mapping (uint => StudentDetails) students;
    mapping (uint => Score) scores;

    event studentAdded(string _firstName, string _lastName, uint256 _studentId);

    event studentScoreRecoded(
        uint256 _studentId,
        uint256 _englishMarks,
        uint256 _mathsMarks,
        uint256 _sciencemMarks);

    function addStudentDetails (
        string memory _firstName,
        string memory _lastName
        ) public onlyClassTechaer (msg.sender) {
        StudentDetails storage studentObj = students[studentsCount];
        studentObj.firstName = _firstName;
        studentObj.lastName = _lastName;
        studentObj.studentId = studentsCount;
        emit studentAdded(_firstName, _lastName, studentsCount);
        studentsCount++;
    }

    function addStudentScores (
        uint256 _studentId,
        uint256 _englishMarks,
        uint256 _mathsMarks,
        uint256 _sciencemMarks
    ) public onlyClassTechaer (msg.sender) {
        Score storage score = scores[_studentId];
        score.englishMarks = _englishMarks;
        score.mathsMarks = _mathsMarks;
        score.sciencemMarks = _sciencemMarks;
        score.studentId = _studentId;

        emit studentScoreRecoded(_studentId, _englishMarks, _mathsMarks, _sciencemMarks);
    }
}