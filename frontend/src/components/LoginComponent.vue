<template>
  <v-container
    fluid
    class="fill-height"
  >
    <v-responsive
      class="align-centerfill-height mx-auto"
    >
      <v-row
        no-gutters
        class="fill-height"
      >
        <v-col
          md="4"
          sm="8"
          offset-md="4"
          offset-sm="2"
        >
          <v-card class="login-card pa-4 mx-auto">
            <v-card-title class="d-flex align-center">
              <img 
                src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Google_Authenticator_%28April_2023%29.svg/2048px-Google_Authenticator_%28April_2023%29.svg.png" 
                alt="logo"
                width="80"
                height="80"
              >
              <div class="ml-4">
                <h3>Welcome to CAS</h3>
                <p class="text-subtitle-1 font-weight-thin">
                  Please sign in to your account.
                </p>
              </div>
            </v-card-title>


            <v-card-text>
              <v-form class="mt-4">
                <v-text-field
                  v-model="username"
                  label="Username"
                  prepend-inner-icon="mdi-email-outline"
                  placeholder="Enter your username"
                  variant="outlined"
                  required
                />
                
                <v-text-field
                  v-model="password"
                  label="Password"
                  variant="outlined"
                  :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                  :type="visible ? 'text' : 'password'"
                  placeholder="Enter your password"
                  prepend-inner-icon="mdi-lock-outline"
                  required
                  @click:append-inner="visible = !visible"
                />

                <v-btn
                  v-if="!isSignup"
                  :disabled="loading"
                  :loading="loading"
                  class="text-none mb-4"
                  color="#3A3585"
                  size="x-large"
                  variant="flat"
                  block
                  rounded="lg"
                  @click="hLogin"
                >
                  Sign in
                </v-btn>
                <div
                  v-if="!isSignup"
                  class="text-center mt-2"
                >
                  ----- or -----
                </div>
                <v-btn
                  :disabled="loading"
                  :loading="loading"
                  class="text-none mt-4"
                  :color="isSignup ? '#3A3585' : '#fff'"
                  size="x-large"
                  :variant="isSignup ? 'flat' : 'outlined'"
                  block
                  rounded="lg"
                  @click="renderSignUp"
                >
                  Sign up
                </v-btn>
                <div
                  v-if="isSignup"
                  class="text-right mt-4 pointer"
                  @click="isSignup = !isSignup"
                >
                  Already have a account?
                </div>
              </v-form>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-responsive>
  </v-container>
</template>

<script setup>
import { ref, onMounted, h } from "vue";
import { useAppStore } from '@/stores/app';
import { useRouter } from 'vue-router';

const router = useRouter();
import bcrypt from 'bcryptjs';


const store = useAppStore();

let visible = ref(false);
let loading = ref(false);
let isSignup = ref(false);

const username = ref('');
const password = ref('');

const saltRounds = 10;

async function generateSalt() {
  try {
    const salt = await bcrypt.genSalt(saltRounds);
    console.log('Generated Salt:', salt);
    return salt;
  } catch (error) {
    console.error('Error generating salt:', error);
  }
}

// generate random salt
generateSalt();


async function hLogin() {
  // loading = !loading

  if (!username.value || !password.value) {
    // loading = !loading

    // show error message
    alert('Please enter username and password');

    return;
  }
  
  let hashedUsername = username.value;
  let hashedPassword = await bcrypt.hash(password.value, saltRounds);

  try {
    if (isSignup.value) {
      // create new user
      const response = await store.createUser(hashedUsername, password.value);

      if (response.status === 201) {
        alert('User created successfully, please login to continue');
        isSignup.value = false;
      } else {
        // show error message
        alert('Failed to create user');
      }
      console.log('Signup response:', response);
    } else {
      const response = await store.login(hashedUsername, password.value);

      if (response.status === 200) {
        // redirect to dashboard
        console.log('Redirecting to dashboard');
        localStorage.setItem("access_token", response.data.access_token);
        router.push('/dashboard'); 
      } else {
        // show error message
        alert('Invalid username or password');
      }
    }
  } catch (error) {
    console.error('Error logging in:', error);
  }

  // loading = !loading
}

function renderSignUp() {
  if (isSignup.value) {
    hLogin();
  } else {
    isSignup.value = true;
  }
}

onMounted(() => {
  store.fetchUsers();
});
</script>


<style>
.v-container {
  animation: background-move-vertical 50s linear infinite;
  background: url("https://solutionapps.smsgupshup.com/one-dashboard/static/media/login.1826da9c3a0dfef0246d.png");
  height: calc(100vh + 600px);
  top: -300px;
  width: 100vw;
  
}

.pointer {
  cursor: pointer;
}

@keyframes background-move-vertical {
  0% {
    background-position: 50% 0%;
  }
  50% {
    background-position: 50% 100%;
  }
  100% {
    background-position: 50% 0%;
  }
}

</style>