<template>
  <v-container
    fluid
    class="fill-height selfstart"
  >
    <v-app-bar :elevation="2">
      <template #prepend>
        <img
          src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Google_Authenticator_%28April_2023%29.svg/2048px-Google_Authenticator_%28April_2023%29.svg.png"
          alt="logo"
          width="40"
          height="40"
        >
      </template>

      <v-app-bar-title>CAS Application</v-app-bar-title>
    </v-app-bar>

    <v-navigation-drawer
      theme="dark"
      permanent
    >
      <v-list>
        <v-list-item
          prepend-icon="mdi-view-dashboard"
          title="Dashboard"
          value="dashboard"
        />
      </v-list>

      <template #append>
        <div class="pa-2">
          <v-btn
            block
            color="purple"
            @click="logout"
          >
            Logout
          </v-btn>
        </div>
      </template>
    </v-navigation-drawer>
      
    <v-card 
      class="pa-4 fill-height"
      width="100%"
    >
      <v-row>
        <v-col cols="12">
          <div class="d-flex">
            <div class="ml-4">
              <h2>Applcations</h2>
            </div>
            <v-btn
              class="ml-4"
              color="purple"
              @click="dialog = !dialog"
            >
              Create
            </v-btn>
          </div>
          <v-text-field
            v-model="search"
            class="mt-4 ml-4 mr-4"
            label="Search"
            prepend-inner-icon="mdi-magnify"
            variant="outlined"
            hide-details
            single-line
          />
        </v-col>
        <v-col cols="12">
          <v-data-table
            :search="search"
            :items="store.apps"
          />
        </v-col>
      </v-row>
    </v-card>

    <v-dialog
      v-model="dialog"
      max-width="600"
    >
      <v-card
        prepend-icon="mdi-application"
        title="Application Profile"
      >
        <v-card-text>
          <v-row dense>
            <v-col
              cols="12"
              sm="6"
            >
              <v-text-field
                v-model="app_name"
                label="App name*"
                required
              />
            </v-col>

            <v-col
              cols="12"
              sm="6"
            >
              <v-select
                v-model="auth_method"
                :items="['plain', 'plain-jwt']"
                label="Auth method*"
                required
              />
            </v-col>
          </v-row>

          <small class="text-caption text-medium-emphasis">*indicates required field</small>
        </v-card-text>

        <v-divider />

        <v-card-actions>
          <v-spacer />

          <v-btn
            text="Close"
            variant="plain"
            @click="dialog = false"
          />

          <v-btn
            color="primary"
            text="Save"
            variant="tonal"
            @click="saveApplication"
          />
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useAppStore } from '@/stores/app';
import { useRouter } from 'vue-router';

const router = useRouter();

let dialog = ref(false);
let app_name = ref('');
let auth_method = ref('');
let search = ref('');

const store = useAppStore();
onMounted(() => {
  store.fetchApps();
});

async function logout() {
  localStorage.removeItem('access_token');
  router.push('/');
}

async function saveApplication() {

  if (!app_name.value || !auth_method.value) {
    alert('Please fill all required fields');
    return;
  }

  try {
    const response = await store.saveApp({
      name: app_name.value,
      auth_method: auth_method.value
    });

    if (response.status === 401) {
      router.push('/');
    }
    if (response.status === 201) {
      dialog.value = false;
      app_name.value = '';
      auth_method.value = '';

      await store.fetchApps();
      alert('Application saved successfully');
    } else {
      alert('Failed to save application');
    }
  } catch (error) {
    alert('Failed to save application');
  }
}

</script>

<style>
.v-container {
  animation: background-move-vertical 50s linear infinite;
  background: url("https://solutionapps.smsgupshup.com/one-dashboard/static/media/login.1826da9c3a0dfef0246d.png");
  height: calc(100vh + 600px);
  top: -300px;
  width: 100vw;
  
}

.selfstart {
  align-items: flex-start !important;
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