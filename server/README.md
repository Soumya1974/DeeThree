Folder Structure:

deethree/
├── src/
│   ├── api/
│   │   ├── app.ts                  # builds the Express app (middleware, routes)
│   │   ├── server.ts               # entry point: listen + graceful shutdown
│   │   ├── routes.ts               # mounts every module's router under /v1
│   │   └── middleware/
│   │       ├── authenticate.ts     # verifies JWT, sets req.user
│   │       ├── authorize.ts        # role / ownership checks
│   │       ├── validate.ts         # Zod request validation
│   │       ├── rateLimit.ts
│   │       ├── requestId.ts
│   │       └── errorHandler.ts
│   │
│   ├── worker/
│   │   ├── worker.ts               # entry point: starts BullMQ workers + shutdown
│   │   ├── processors/
│   │   │   ├── validateBlend.processor.ts
│   │   │   └── cleanupUploads.processor.ts
│   │   └── blender/
│   │       ├── runBlender.ts       # spawns headless Blender with timeout/limits
│   │       └── validate_blend.py   # script executed inside Blender
│   │
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── auth.routes.ts
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.repository.ts
│   │   │   ├── auth.schemas.ts     # Zod schemas
│   │   │   ├── token.service.ts    # JWT + refresh rotation
│   │   │   └── google.oauth.ts
│   │   ├── users/
│   │   ├── characters/             # the 3-4 platform models
│   │   ├── animations/
│   │   ├── uploads/                # presigned flow, upload sessions
│   │   ├── downloads/
│   │   ├── ratings/
│   │   ├── votes/
│   │   ├── comments/
│   │   ├── follows/
│   │   └── email/                  # verification emails
│   │       (each one has the same routes / controller / service /
│   │        repository / schemas / types layout as auth)
│   │
│   ├── shared/
│   │   ├── config/                 # env loading + Zod validation
│   │   ├── db/
│   │   │   ├── pool.ts             # pg Pool
│   │   │   └── transaction.ts      # withTransaction() helper
│   │   ├── redis/
│   │   │   ├── client.ts
│   │   │   └── cache.ts            # cache-aside helpers
│   │   ├── queue/
│   │   │   ├── queues.ts           # queue definitions
│   │   │   └── jobs.types.ts       # job payload types
│   │   ├── storage/
│   │   │   └── s3.ts               # presign, head, copy, delete
│   │   ├── errors/                 # AppError, NotFound, Conflict, etc.
│   │   ├── logger/                 # pino setup
│   │   ├── utils/                  # pagination (cursor), hashing, ids
│   │   └── types/                  # express.d.ts, shared types
│   │
│   └── index.d.ts
│
├── migrations/                     # node-pg-migrate SQL/TS files
├── seeds/
│   ├── characters.seed.ts          # safe to run in prod
│   └── dev.seed.ts                 # fake users/animations, dev only
├── tests/
│   ├── unit/
│   ├── integration/
│   └── helpers/
├── docker/
│   ├── api.Dockerfile
│   └── worker.Dockerfile           # includes headless Blender
├── docker-compose.yml              # dev: postgres, redis, minio
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
└── README.md

npm run migrate:create characters