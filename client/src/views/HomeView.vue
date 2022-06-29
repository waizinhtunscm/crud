<template>
  <div class="home">
    <!-- <img alt="Vue logo" src="../assets/logo.png" /> -->
    <b-row>
      <data-table></data-table>
    </b-row>
  </div>
</template>

<script>
// @ is an alias to /src
import DataTable from "@/components/DataTable.vue";

export default {
  name: "HomeView",
  components: {
    DataTable,
  },
};
</script>
