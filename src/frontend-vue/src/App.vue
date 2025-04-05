<script>
export default {
  data() {
    return {
      expression: '',
      result: ''
    };
  },
  methods: {
    parseExpression(expr) {
      const tokens = [];
      for (let char of expr.replace(/\s+/g, '')) {
        if (['+', '-', '='].includes(char)) {
          tokens.push("'" + char + "'");
        } else if (!isNaN(char)) {
          tokens.push(char);
        } else {
          return null;
        }
      }
      return `[${tokens.join(',')}]`;
    },

    async solve(endpoint) {
      const parsed = this.parseExpression(this.expression);
      if (!parsed) {
        this.result = '❌ Invalid input!';
        return;
      }
      try {
        const response = await fetch(`/${endpoint}?input=${encodeURIComponent(parsed)}`);
        this.result = await response.text();
      } catch (err) {
        this.result = '❌ Error: ' + err.message;
      }
    }
  }
};
</script>

<template>
  <div class="container">
    <h1>Matchstick Puzzle</h1>
    <input v-model="expression" placeholder="Enter: 15+2=21" />
    <button @click="solve('game_add_1')">Solve with 1 match</button>
    <button @click="solve('game_add_2')">Solve with 2 matches</button>

    <div v-if="result">
      <h3>Result</h3>
      <pre>{{ result }}</pre>
    </div>
  </div>
</template>

<style>
@font-face {
  font-family: 'SevenSegment';
  src: url('./assets/Seven_Segment.ttf') format('truetype');
}


.container {
  max-width: 600px;
  margin: 50px auto;
  padding: 2rem;
  background: #3d3d3d;
  border-radius: 1rem;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
input, button {
  display: block;
  width: 100%;
  margin-top: 1rem;
  padding: 0.8rem;
  font-size: 1rem;
}
pre {
  background: #414141;
  padding: 1rem;
  border-radius: 0.5rem;
  white-space: pre-wrap;
}

input, pre {
  font-family: 'SevenSegment', monospace;
  font-size: 1.5rem;
  letter-spacing: 0.05em;
}


</style>
