<template>
  <div>
    <b-row class="mt-2 mb-3">
      <h6 class="text-secondary">Are you sure you want to delete this user?</h6>
    </b-row>
    <b-row class="mt-2 mb-3">
      <p class="text-danger">
        This action is not reversible and may result in the loss if important
        data.
      </p>
    </b-row>
    <b-row class="mt-4">
      <b-col>
        <b-button variant="danger" @click="removeUserFromData"
          >Delete User</b-button
        >
      </b-col>
    </b-row>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "DeleteUserModal",
  props: {
    userId: Number,
  },
  methods: {
    triggerClose() {
      this.$emit("closeDeleteModal");
    },
    removeUserFromData() {
      axios
        .delete(`http://localhost:3000/api/v1/users/${this.userId}`)
        .then(() => {
          this.$emit("reloadDataTable");
          this.$emit("showDeleteAlert");
          this.$emit("closeDeleteModal");
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
