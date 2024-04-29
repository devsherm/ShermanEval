import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  validate(event) {
    const skillCheckboxes = document.querySelectorAll('input[name="applicant[skills][]"]:checked');
    
    // console.log("Skill Checkboxes:", skillCheckboxes.length);

    const skillsChecked = skillCheckboxes.length > 0;

    if (!skillsChecked) {
      event.preventDefault();
      alert('Please select at least one skill.');
    }
  }
}
