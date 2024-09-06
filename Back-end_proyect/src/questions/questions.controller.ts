import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { QuestionsService } from './questions.service';
import { CreateQuestionDto } from './dto/create-question.dto';
import { UpdateQuestionDto } from './dto/update-question.dto';
import { PaginationDto } from 'src/common/dto/pagination.dto';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { Auth, RoleProtected } from 'src/auth/decorators';
import { ValidRoles } from 'src/auth/interfaces';
import { UserRoleGuard } from 'src/auth/guards';
import { AuthGuard } from '@nestjs/passport';

@Auth()
@ApiTags('Preguntas de los temas')
@Controller('questions')
export class QuestionsController {
  constructor(private readonly questionsService: QuestionsService) {}

  @Post()
  @RoleProtected(ValidRoles.teacher, ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  @ApiOperation({ summary: 'Crear nuevas preguntas' })
  @ApiResponse({
    status: 201,
    description: 'Las preguntas han sido creadas exitosamente.',
  })
  @ApiResponse({
    status: 400,
    description: 'Bad Request. Los datos de entrada son inválidos.',
  })
  create(@Body() createQuestionsDto: CreateQuestionDto[]) {
    return this.questionsService.createMultiple(createQuestionsDto);
  }
  //Obtener todas las preguntas de un tema con paginación
  @Get('topic/:topicId')
  @ApiOperation({
    summary: 'Obtener todas las preguntas de un tema con paginación',
  })
  @ApiResponse({
    status: 200,
    description: 'Las preguntas han sido obtenidas exitosamente.',
  })
  @ApiResponse({
    status: 404,
    description:
      'Not Found. No se encontraron preguntas para el tema especificado.',
  })
  @ApiParam({
    name: 'topicId',
    description: 'Identificador único del tema',
    example: 'd1e9f16b-23b4-4c7f-9187-8fc8f76d8f6c',
  })
  findAllByTopic(
    @Param('topicId') topicId: string,
    @Query() paginationDTO: PaginationDto,
  ) {
    return this.questionsService.findAllByTopic(topicId, paginationDTO);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una pregunta por ID' })
  @ApiResponse({
    status: 200,
    description: 'La pregunta ha sido obtenida exitosamente.',
  })
  @ApiResponse({
    status: 404,
    description:
      'Not Found. No se encontró la pregunta con el ID especificado.',
  })
  findOne(@Param('id') id: string) {
    return this.questionsService.findOne(id);
  }

  @Patch(':id')
  @RoleProtected(ValidRoles.teacher, ValidRoles.admin)
  @UseGuards(AuthGuard(), UserRoleGuard)
  @ApiOperation({ summary: 'Actualizar una pregunta por ID' })
  @ApiResponse({
    status: 200,
    description: 'La pregunta ha sido actualizada exitosamente.',
  })
  @ApiResponse({
    status: 400,
    description: 'Bad Request. Los datos de entrada son inválidos.',
  })
  @ApiResponse({
    status: 404,
    description:
      'Not Found. No se encontró la pregunta con el ID especificado.',
  })
  update(
    @Param('id') id: string,
    @Body() updateQuestionDto: UpdateQuestionDto,
  ) {
    return this.questionsService.update(id, updateQuestionDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar una pregunta por ID' })
  @ApiResponse({
    status: 200,
    description: 'La pregunta ha sido eliminada exitosamente.',
  })
  @ApiResponse({
    status: 404,
    description:
      'Not Found. No se encontró la pregunta con el ID especificado.',
  })
  remove(@Param('id') id: string) {
    return this.questionsService.remove(id);
  }
}
