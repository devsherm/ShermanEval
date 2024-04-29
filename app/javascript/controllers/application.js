import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }


document.addEventListener('DOMContentLoaded', function () {
    alert("3")
    var form = document.getElementById('applicant_form');
    if (form) {
        form.addEventListener('submit', function (event) {
            var skills = document.querySelectorAll('#skills_field input[type="checkbox"]');
            var skillsChecked = Array.from(skills).some(function (skill) {
                return skill.checked;
            });
            if (!skillsChecked) {
                event.preventDefault();
                alert('Please select at least one skill.');
            }
        });
    }
});
