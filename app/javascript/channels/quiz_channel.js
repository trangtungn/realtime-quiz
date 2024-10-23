import consumer from "./consumer"

let quizSubscription = null;

document.addEventListener('turbo:load', () => {
  const quizElement = document.getElementById('quiz')
  if (quizElement) {
    const quizId = quizElement.dataset.quizId

    if (!quizSubscription) {
      quizSubscription = consumer.subscriptions.create({ channel: "QuizChannel", id: quizId }, {
      connected() {
        console.log(`Connected to QuizChannel ${quizId}`)
      },

      disconnected() {
        console.log(`Disconnected from QuizChannel ${quizId}`)
      },

      received(data) {
        console.log("Received data:", data)
        this.addParticipant(data)
      },

      addParticipant(data) {
        const participantCountElement = document.getElementById('participants_count')

        if (participantCountElement) {
          participantCountElement.textContent = data.participation_count
        }

        const participantListElement = document.getElementById('participations_list')
        if (participantListElement) {
          // Assuming you have a way to render a new participant
          // You might want to create a separate function for this
          const newParticipantElement = this.renderParticipant(data.participant)
          participantListElement.appendChild(newParticipantElement)
        }
      },

      renderParticipant(participant) {
        const li = document.createElement('li')
        li.textContent = participant // Adjust this based on your data structure
        return li
      }
      })
    }
  } else {
    if (quizSubscription) {
      quizSubscription.unsubscribe();
      quizSubscription = null;
    }
  }
})
