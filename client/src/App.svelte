<script lang="ts">
  import * as Card from './lib/components/ui/card/index';
  import * as Accordion from './lib/components/ui/accordion/index';
  import { Input } from './lib/components/ui/input/index';
  import { Label } from './lib/components/ui/label/index';
  import { Button } from './lib/components/ui/button/index';
  import { Separator } from './lib/components/ui/separator/index';
  import './app.css';

  let questions = $state<Question[]>([]);
  type QuestionDto = {
    question_id: number;
    question_text: string;
  };
  type Question = {
    id: number;
    questionText: string;
  };
  const mapQuestions = (question: QuestionDto) => {
    return {
      id: question.question_id,
      questionText: question.question_text,
    } as Question;
  };
  async function getQuestions() {
    const response = await fetch('http://localhost:8000/api/question');
    const data = await response.json();
    questions = data.map(mapQuestions);
  }
</script>

<main class="container mx-auto pt-5 max-w-[80%]">
  <h1 class="scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl">
    Questions API
  </h1>
  <Separator class="mb-5" />
  <Card.Root class="mb-5">
    <Card.Content>
      <Button onclick={getQuestions}>Get Questions</Button>
      <Accordion.Root type="single" class="w-full sm:max-w-[70%]">
        {#each questions as question}
          <Accordion.Item value={question.id}>
            <Accordion.Trigger>{question.questionText}</Accordion.Trigger>
            <Accordion.Content>{question.questionText}</Accordion.Content>
          </Accordion.Item>
        {/each}
      </Accordion.Root>
    </Card.Content>
  </Card.Root>

  <Card.Root class="mb-5">
    <Card.Header>
      <Card.Title>Post a Question</Card.Title>
    </Card.Header>
    <Card.Content>
      <form
        onsubmit={async (event) => {
          event.preventDefault();
          event.stopPropagation();
          const formData = new FormData(event.target as HTMLFormElement);
          const questionText = formData.get('question') as string;
          const response = await fetch('http://localhost:8000/api/question', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ question_text: questionText }),
          });
          if (response.ok) {
            // @ts-ignore
            document.getElementById('question').value = '';
            const question = await response.json();
            questions = [...questions, mapQuestions(question)];
          }
        }}
        class="flex flex-col items-center justify-evenly"
      >
        <Label for="question" class="font-bold text-lg mb-2 ">
          What is the question text?
        </Label>
        <div class="flex space-x-2">
          <Input type="text" id="question" name="question" required />
          <Button type="submit">Submit</Button>
        </div>
      </form>
    </Card.Content>
  </Card.Root>
</main>
