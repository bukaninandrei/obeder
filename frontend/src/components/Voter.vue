<template>
  <div class="voter">
    <a href="javascript:void(0)"
       @click="onVote(1)"
       class="vote vote_like"
       v-bind:class="{ vote_like_active: isVoted(1) }"
    ></a>
    <span class="rating">{{ rating }}</span>
    <a href="javascript:void(0)"
       @click="onVote(-1)"
       class="vote vote_dislike"
       v-bind:class="{ vote_dislike_active: isVoted(-1) }"
    ></a>
  </div>
</template>
<script>
  import usersService from 'api/users';

  export default {
    name: 'Voter',
    props: {
      dishId: Number,
      rating: Number,
      voteType: Number,
    },
    methods: {
      isVoted(voteType) {
        return this.voteType === voteType;
      },
      onVote(voteType) {
        if (this.voteType === voteType) return;
        this.voteType = voteType;
        this.sendData();
      },
      sendData() {
        usersService
          .setVote(this.dishId, this.voteType)
          .then((response) => {
            if (!response.errors) {
              this.rating = response.rating;
            }
          });
      },
    },
  };
</script>
<style>
  .voter {
    width: 20px;
    display: inline-block;
    margin: 0 0 3px;

    & .vote {
      display: inline-block;
      position: relative;
      margin: 0 5px;
      border: 10px solid transparent;
    }

    & .vote_like {
      border-bottom: 10px solid #aaa8a5;
    }

    & .vote_dislike {
      border-top: 10px solid #aaa8a5;
    }

    & .vote_like:hover, & .vote_like_active {
      border-bottom-color: #beee44;
    }

    & .vote_like_active, & .vote_dislike_active {
      cursor: default;
    }

    & .vote_dislike:hover, & .vote_dislike_active {
      border-top-color: #efd245;
    }

    & .rating {
      display: inline-block;
      width: 30px;
      position: relative;
      text-align: center;
      font-size: 14pt;
      margin: 6px 0 8px;
    }
  }
</style>
