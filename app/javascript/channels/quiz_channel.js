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
        this.addParticipant(data)
      },

      addParticipant(data) {
        const participantCountElement = document.getElementById('participants_count')
        participantCountElement.textContent = data.participation_count

        const participantListElement = document.getElementById('participations_list')
        const newParticipantElement = this.renderParticipant(data.participant)
        participantListElement.appendChild(newParticipantElement)
      },

      renderParticipant(participant) {
        const li = document.createElement('li')
        li.textContent = participant
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
