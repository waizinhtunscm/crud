<template>
  <b-form class="mt-3">
    <b-row>
      <b-col cols="6">
        <b-form-group id="first-name" label="First Name" label-for="first-name">
          <b-form-input
            id="first-name"
            type="text"
            placeholder="First Name"
            v-model="user.first_name"
          ></b-form-input>
        </b-form-group>
      </b-col>
      <b-col cols="6">
        <b-form-group id="last-name" label="Last Name" label-for="last-name">
          <b-form-input
            id="last-name"
            type="text"
            placeholder="Last Name"
            v-model="user.last_name"
          ></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="mt-3">
      <b-col cols="6">
        <b-form-group id="email" label="E-Mail" label-for="email">
          <b-form-input
            id="email"
            type="email"
            placeholder="example@crm.com"
            v-model="user.email"
          ></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row>
      <b-col cols="6">
        <b-form-group id="password" label="Password" label-for="password">
          <b-form-input
            id="password"
            type="text"
            v-model="user.password"
          ></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row>
      <b-col cols="6">
        <b-form-group id="dob" label="Date of Birth" label-for="dob">
          <b-form-input id="dob" type="date" v-model="user.dob"></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="mt-3">
      <b-col cols="6">
        <b-form-group id="address" label="Address" label-for="address">
          <b-form-textarea
            id="address"
            type="address"
            v-model="user.address"
          ></b-form-textarea>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="mt-2">
      <b-form-checkbox
        id="status"
        v-model="user.status"
        name="status"
        value="active"
        unchecked-value="inactive"
      >
        User is active
      </b-form-checkbox>
    </b-row>
    <b-row class="mt-4">
      <b-col cols="3">
        <b-button variant="primary" class="px-5" @click="addNewUser"
          >Add User</b-button
        >
      </b-col>
    </b-row>
  </b-form>
</template>

<script>
import axios from "axios";

export default {
  name: "CreateUserModal",
  data() {
    return {
      user: {},
    };
  },
  methods: {
    triggerClose() {
      this.$emit("closeCreateModal");
    },
    addNewUser() {
      axios
        .post("http://localhost:3000/api/v1/users/", this.user)
        .then((response) => {
          console.log(response.data);
          this.$emit("closeCreateModal");
          this.$emit("reloadDataTable");
          this.$emit("showSuccessAlert");
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
