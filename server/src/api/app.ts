import express from "express";
import { errorHandler } from "./middleware/errorHandler.ts";
import { AppError } from "../shared/errors/AppError.ts";

const app = express();
app.use(express.json( { limit: "10kb"} ));



app.use((req, res, next) => {
    next(new AppError(404, `Route ${req.method} ${req.originalUrl} not found`));
});

app.use(errorHandler);

export default app;