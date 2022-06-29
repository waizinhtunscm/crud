<template>
  <div>
    <b-row class="text-center">
      <b-col>
        <div
          class="filter-card p-3"
          :class="{
            'bg-active-filter': totalIsActive,
            'bg-light': !totalIsActive,
          }"
          @click="totalUsersIsActiveFilter"
        >
          <h6>Total Users</h6>
          <h4>
            <strong>{{ totalUsers }}</strong>
          </h4>
        </div>
      </b-col>
      <b-col>
        <div
          class="filter-card p-3"
          :class="{
            'bg-active-filter': activeIsActive,
            'bg-light': !activeIsActive,
          }"
          @click="activeUsersIsActiveFilter"
        >
          <h6 class="text-secondary">Active Users</h6>
          <h4>
            <strong>{{ activeUsers }}</strong>
          </h4>
        </div>
      </b-col>
    </b-row>
  </div>
</template>

<script>
export default {
  name: "UserOverview",
  props: {
    totalUsers: Number,
    activeUsers: Number,
  },
  data() {
    return {
      totalIsActive: true,
      activeIsActive: false,
    };
  },
  methods: {
    totalUsersIsActiveFilter() {
      this.totalIsActive = true;
      this.activeIsActive = false;
      this.$emit("totalUsersIsActive");
    },
    activeUsersIsActiveFilter() {
      this.totalIsActive = false;
      this.activeIsActive = true;
      this.$emit("activeUsersIsActive");
    },
  },
};
</script>

<style>
.filter-card:hover {
  cursor: pointer;
  text-decoration: underline;
}

.bg-active-filter {
  background-color: #e9f1fe;
  color: #074297;
}
</style>