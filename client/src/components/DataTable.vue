<template>
  <div>
    <b-row>
      <b-alert v-model="showSuccessAlert" variant="success" dismissible>
        {{ alertMessage }}
      </b-alert>
    </b-row>
    <b-row>
      <user-overview
        :totalUsers="numberOfUsers"
        :activeUsers="activeUsers"
        @totalUsersIsActive="setFilterTotalIsActive"
        @activeUsersIsActive="setFilterActiveIsActive"
      ></user-overview>
    </b-row>
    <b-row class="mt-3">
      <b-card>
        <b-row align-h="between">
          <b-col cols="6">
            <h3>{{ tableHeader }}</h3>
          </b-col>
          <b-col cols="2">
            <b-row>
              <b-col>
                <b-button
                  variant="primary"
                  id="show-btn"
                  @click="showCreateModal"
                >
                  <b-icon-plus class="text-white"></b-icon-plus>
                  <span class="h6 text-white">New User</span>
                </b-button>
              </b-col>
            </b-row>
          </b-col>
        </b-row>
        <b-row class="mt-3">
          <b-table
            striped
            hover
            :items="items"
            :fields="fields"
            class="text-center"
          >
            <template #cell(name)="data">
              <div class="d-flex flex-row td-text">
                <div v-if="data.item.first_name">
                  {{ `${data.item.first_name}` }}
                </div>
                <div v-if="data.item.last_name">
                  {{ ` ${data.item.last_name}` }}
                </div>
              </div>
            </template>
            <template #cell(email)="data">
              <div class="d-flex flex-row td-text">
                <div v-if="data.item.email">
                  {{ `${data.item.email}` }}
                </div>
              </div>
            </template>
            <template #cell(dob)="data">
              <div v-if="data.item.dob">{{ `${data.item.dob}` }}</div>
              <div v-else>-</div>
            </template>
            <template #cell(status)="data">
              <b-icon-bookmark-check-fill
                variant="success"
                v-if="data.item.status === 'active'"
              ></b-icon-bookmark-check-fill>
              <b-icon-bookmark-x-fill
                variant="danger"
                v-else
              ></b-icon-bookmark-x-fill>
            </template>
            <template #cell(actions)="data">
              <b-row>
                <b-col cols="6">
                  <b-icon-pencil-square
                    class="action-item"
                    variant="primary"
                    @click="getRowData(data.item.id)"
                  ></b-icon-pencil-square>
                </b-col>
                <b-col cols="1">
                  <b-icon-trash-fill
                    class="action-item"
                    variant="danger"
                    @click="showDeleteModal(data.item.id)"
                  ></b-icon-trash-fill>
                </b-col>
              </b-row>
            </template>
          </b-table>
        </b-row>
      </b-card>
    </b-row>

    <!-- Modal for adding new users -->
    <b-modal ref="create-user-modal" size="xl" hide-footer title="New User">
      <create-user-form
        @closeCreateModal="closeCreateModal"
        @reloadDataTable="getUserData"
        @showSuccessAlert="showAlertCreate"
      ></create-user-form>
    </b-modal>

    <!-- Modal for updating users -->
    <b-modal ref="edit-user-modal" size="xl" hide-footer title="Edit User">
      <edit-user-form
        @closeEditModal="closeEditModal"
        @reloadDataTable="getUserData"
        @showSuccessAlert="showAlertUpdate"
        :userId="userId"
      ></edit-user-form>
    </b-modal>

    <!-- Delete User Modal -->
    <b-modal
      ref="delete-user-modal"
      size="md"
      hide-footer
      title="Confirm Deletion"
    >
      <delete-user-modal
        @closeDeleteModal="closeDeleteModal"
        @reloadDataTable="getUserData"
        @showDeleteAlert="showDeleteSuccessModal"
        :userId="userId"
      ></delete-user-modal>
    </b-modal>
  </div>
</template>

<script>
import axios from "axios";
import UserOverview from "@/components/UserOverview.vue";
import CreateUserForm from "@/components/CreateUserForm.vue";
import EditUserForm from "@/components/EditUserForm.vue";
import DeleteUserModal from "@/components/DeleteUserModal.vue";

export default {
  components: {
    UserOverview,
    CreateUserForm,
    EditUserForm,
    DeleteUserModal,
  },
  data() {
    return {
      // Note 'isActive' is left out and will not appear in the rendered table

      fields: [
        {
          key: "name",
          label: "Name",
          sortable: false,
          thStyle: { width: "20%" },
          thClass: "td-text",
        },
        {
          key: "email",
          label: "E-Mail",
          sortable: false,
          thClass: "td-text",
        },
        {
          key: "dob",
          label: "Date of Birth",
          sortable: false,
        },
        {
          key: "status",
          label: "User Status",
          sortable: false,
        },
        "actions",
      ],
      items: [],
      numberOfUsers: 0,
      activeUsers: 0,
      activeUsersData: [],
      userId: 0,
      userSearchTerm: "",
      tableHeader: "",
      showSuccessAlert: false,
      alertMessage: "",
    };
  },
  mounted() {
    this.getUserData();
  },
  methods: {
    showCreateModal() {
      this.$refs["create-user-modal"].show();
    },
    closeCreateModal() {
      this.$refs["create-user-modal"].hide();
    },
    getUserData() {
      axios
        .get("http://localhost:3000/api/v1/users/")
        .then((response) => {
          this.tableHeader = "Total User";
          this.items = response.data;
          this.numberOfUsers = response.data.length;
          this.activeUsersData = response.data.filter(
            (item) => item.status === "active"
          );
          this.activeUsers = this.activeUsersData.length;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getRowData(id) {
      this.$refs["edit-user-modal"].show();
      this.userId = id;
    },
    closeEditModal() {
      this.$refs["edit-user-modal"].hide();
    },
    setFilterTotalIsActive() {
      this.tableHeader = "Total Users";
      this.getUserData();
    },
    setFilterActiveIsActive() {
      this.tableHeader = "Active Users";
      this.items = this.activeUsersData;
    },
    showAlertCreate() {
      this.showSuccessAlert = true;
      this.alertMessage = "User was created successfully!";
    },
    showAlertUpdate() {
      this.showSuccessAlert = true;
      this.alertMessage = "User was updated successfully";
    },
    showDeleteModal(id) {
      this.$refs["delete-user-modal"].show();
      this.userId = id;
    },
    closeDeleteModal() {
      this.$refs["delete-user-modal"].hide();
    },
    showDeleteSuccessModal() {
      this.showSuccessAlert = true;
      this.alertMessage = "User was deleted successfully!";
    },
  },
};
</script>

<style>
.action-item:hover {
  cursor: pointer;
}
.td-text {
  text-align: left;
}
</style>
